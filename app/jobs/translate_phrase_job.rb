class TranslatePhraseJob < ApplicationJob
  def perform(phrase_id)
    phrase = Phrase.find_by(id: phrase_id)

    return unless phrase

    phrase.in_progress!
    phrase.broadcast_update

    Translations::TranslatePhrase.call(phrase: phrase)

    phrase.broadcast_update

    UpdateLanguageUsageJob.perform_later(phrase.translation.user_id)
  end
end
