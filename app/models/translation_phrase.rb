class TranslationPhrase < ApplicationRecord
  belongs_to :translation

  enum status: { pending: 0, in_progress: 1, translated: 2, failed: 3 }

  def broadcast_update
    ActionCable.server.broadcast "translation_#{translation_id}", as_json(only: %i[id status text_to])
  end
end
