class TranslationPhrase < ApplicationRecord
  belongs_to :translation

  enum status: { pending: 0, in_progress: 1, translated: 2, failed: 3 }
end
