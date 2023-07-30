class TranslationPhrasesController < ApplicationController
  def create
    new_translation = false
    translation_id = params[:translation_phrase][:translation_id]
    translation = if translation_id.present?
                    current_or_guest_user.translations.find(translation_id)
                  else
                    new_translation = true
                    current_or_guest_user.translations.create!(name: translation_phrase_params[:text_from])
                  end

    translation_phrase = translation.translation_phrases.create(translation_phrase_params)

    if translation_phrase.persisted?
      TranslatePhraseWorker.perform_async(translation_phrase.id)

      if new_translation
        redirect_to translation_path(translation)
      else
        render turbo_stream: turbo_stream.append(
          'translation_phrases',
          partial: 'translation_phrases/translation_phrase',
          locals: { translation_phrase: translation_phrase }
        )
      end
    else
      raise translation_phrase.errors.inspect
    end
  end

  private

  def translation_phrase_params
    params.require(:translation_phrase).permit(:lang_from, :lang_to, :text_from)
  end
end
