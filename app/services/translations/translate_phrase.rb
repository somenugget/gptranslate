module Translations
  class TranslatePhrase < Service
    CANT_TRANSLATE_PLACEHOLDER = '---'.freeze

    # @!method translation_phrase
    #  return [TranslationPhrase]
    input :translation_phrase, type: [TranslationPhrase]

    def call
      prompt = generate_prompt(translation_phrase.lang_from, translation_phrase.lang_to, translation_phrase.text_from)

      response = client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: prompt }]
        }
      )

      results = response['choices'].map { |choice| choice['message']['content'] }.reject do |content|
        content == CANT_TRANSLATE_PLACEHOLDER
      end

      if results.any?
        translation_phrase.update!(text_to: results.join, status: :translated)
      else
        translation_phrase.update!(status: :failed)
      end
    end

    private

    def generate_prompt(lang_from, lang_to, text)
      "Translate from #{Translation::LANGUAGES[lang_from]} " \
        "to #{Translation::LANGUAGES[lang_to]}. " \
        'return only the translated text or ' \
        "return #{CANT_TRANSLATE_PLACEHOLDER} if you can't translate." \
        " \n\n#{text}" \
    end

    def client
      @client ||= OpenAI::Client.new
    end
  end
end
