require 'tiktoken_ruby'

class SplitByTokensLimit < Service
  input :text, type: String
  input :tokens_limit, default: 4097
  input :model, default: 'gpt-3.5-turbo'

  def call
    tokens_count(text) < tokens_limit ? [text] : split_text
  end

  private

  def split_text
    [].tap do |text_parts|
      next_part = nil

      text.split('.').each do |text_part|
        appended_next_part = [next_part, text_part].compact.join('.')

        if tokens_count(appended_next_part) > tokens_limit
          text_parts << appended_next_part
          next_part = nil
        else
          next_part = appended_next_part
        end
      end

      text_parts << next_part if next_part.present?
    end
  end

  def tokens_count(text)
    encoding.encode(text).length
  end

  def encoding
    @encoding ||= Tiktoken.encoding_for_model(model)
  end
end
