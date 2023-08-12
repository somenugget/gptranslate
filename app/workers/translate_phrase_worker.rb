class TranslatePhraseWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(phrase_id)
    phrase = Phrase.find_by(id: phrase_id)

    return unless phrase

    phrase.in_progress!
    phrase.broadcast_update

    Translations::TranslatePhrase.call(phrase: phrase)

    phrase.broadcast_update

    UpdateLanguageUsageWorker.perform_async(phrase.translation.user_id)
  end
end
