class TranslatePhraseWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(phrase_id)
    phrase = Phrase.where(status: :pending).find_by(id: phrase_id)

    return unless phrase

    Translations::TranslatePhrase.call(phrase: phrase)

    phrase.broadcast_update
  end
end
