module Translations
  class TranslatePhrase < Service
    MAX_TOKENS_COUNT = 3000
    CANT_TRANSLATE_PLACEHOLDER = '=-=-=-='.freeze

    TranslationFailedError = Class.new(StandardError)

    # @!method phrase
    #  return [Phrase]
    input :phrase, type: [Phrase]

    def call
      prompts = text_parts(phrase.text_from).map do |text_part|
        generate_prompt(phrase.lang_from, phrase.lang_to, text_part)
      end

      results = translate_prompts(prompts)

      if results.any?
        phrase.update!(text_to: results.join('. '), status: :translated)
      else
        phrase.update!(status: :failed)
      end
    end

    private

    def generate_prompt(lang_from, lang_to, text)
      "Translate text in `` from #{Translation::LANGUAGES[lang_from]} " \
        "to #{Translation::LANGUAGES[lang_to]}. " \
        'return only the translated text.' \
        "If you can't translate return '#{CANT_TRANSLATE_PLACEHOLDER}' and the reason. `#{text}`"
    end

    def text_parts(text)
      SplitByTokensLimit.call(
        text: text,
        tokens_limit: MAX_TOKENS_COUNT
      ).output
    end

    def translate_prompts(prompts)
      prompts.flat_map do |prompt|
        response = get_chat_response(prompt)

        pp prompt
        pp response

        response['choices'].map { |choice| choice['message']['content'] }.reject do |content|
          # sometimes network returns only part of the placeholder
          content.include? CANT_TRANSLATE_PLACEHOLDER[0..4]
        end
      end
    end

    def get_chat_response(prompt)
      client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: prompt }]
        }
      )
    end

    def client
      @client ||= OpenAI::Client.new
    end
  end
end
