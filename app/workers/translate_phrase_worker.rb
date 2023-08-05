class TranslatePhraseWorker
  include Sidekiq::Worker

  sidekiq_options retry: 3

  def perform(phrase_id)
    translation_phrase = TranslationPhrase.where(status: :pending).find_by(id: phrase_id)

    return unless translation_phrase

    Translations::TranslatePhrase.call(translation_phrase: translation_phrase)

    translation_phrase.broadcast_update
  end
end
