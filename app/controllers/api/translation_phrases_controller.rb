module Api
  class TranslationPhrasesController < BaseController
    def create
      translation_id = params[:translation_phrase][:translation_id]
      translation = if translation_id.present?
                      current_or_guest_user.translations.find(translation_id)
                    else
                      current_or_guest_user.translations.create!(name: translation_phrase_params[:text_from])
                    end

      translation_phrase = translation.translation_phrases.create(translation_phrase_params)

      if translation_phrase.persisted?
        TranslatePhraseWorker.perform_async(translation_phrase.id)

        render json: translation_phrase
      else
        render json: { errors: translation_phrase.errors }, status: :unprocessable_entity
      end
    end

    private

    def translation_phrase_params
      params.require(:translation_phrase).permit(:lang_from, :lang_to, :text_from)
    end
  end
end
