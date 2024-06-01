module Api
  class PhrasesController < BaseController
    def index
      translation = current_or_guest_user.translations.find(params[:translation_id])

      render json: translation.phrases.order(:created_at)
    end

    def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      phrase = nil
      Translation.transaction do
        translation_id = params[:phrase][:translation_id]
        translation = if translation_id.present?
                        current_or_guest_user.translations.find(translation_id)
                      else
                        current_or_guest_user.translations.create!(name: phrase_params[:text_from][0..30])
                      end

        phrase = translation.phrases.create(phrase_params)
      end

      if phrase.persisted?
        current_or_guest_user.language_from_setting = phrase.lang_from
        current_or_guest_user.language_to_setting = phrase.lang_to
        current_or_guest_user.save!

        TranslatePhraseJob.perform_later(phrase.id)

        render json: phrase
      else
        render json: { errors: phrase.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      phrase = Phrase.find(params[:id])
      phrase.destroy

      render json: phrase
    end

    def retry
      phrase = Phrase.find(params[:id])
      TranslatePhraseJob.perform_later(phrase.id)

      render json: phrase
    end

    private

    def phrase_params
      params.require(:phrase).permit(:lang_from, :lang_to, :text_from)
    end
  end
end
