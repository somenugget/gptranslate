module Api
  class PhrasesController < BaseController
    def create
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
        TranslatePhraseWorker.perform_async(phrase.id)

        render json: phrase
      else
        render json: { errors: phrase.errors }, status: :unprocessable_entity
      end
    end

    def retry
      phrase = Phrase.find(params[:id])
      TranslatePhraseWorker.perform_async(phrase.id)

      render json: phrase
    end

    private

    def phrase_params
      params.require(:phrase).permit(:lang_from, :lang_to, :text_from)
    end
  end
end
