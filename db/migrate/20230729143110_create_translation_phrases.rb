class CreateTranslationPhrases < ActiveRecord::Migration[7.0]
  def change
    create_table :translation_phrases do |t|
      t.references :translation, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.string :lang_from, null: false
      t.string :lang_to, null: false

      t.string :text_from, null: false
      t.string :text_to

      t.timestamps
    end
  end
end
