class CreatePhrases < ActiveRecord::Migration[7.0]
  def change
    create_table(:phrases, options: 'PARTITION BY HASH (id)') do |t|
      t.references :translation, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.string :lang_from, null: false
      t.string :lang_to, null: false

      t.string :text_from, null: false
      t.string :text_to

      t.timestamps
    end

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TABLE phrases_0 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 0);
          CREATE TABLE phrases_1 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 1);
          CREATE TABLE phrases_2 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 2);
          CREATE TABLE phrases_3 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 3);
          CREATE TABLE phrases_4 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 4);
          CREATE TABLE phrases_5 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 5);
          CREATE TABLE phrases_6 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 6);
          CREATE TABLE phrases_7 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 7);
          CREATE TABLE phrases_8 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 8);
          CREATE TABLE phrases_9 PARTITION OF phrases FOR VALUES WITH (MODULUS 10, REMAINDER 9);
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TABLE phrases_0;
          DROP TABLE phrases_1;
          DROP TABLE phrases_2;
          DROP TABLE phrases_3;
          DROP TABLE phrases_4;
          DROP TABLE phrases_5;
          DROP TABLE phrases_6;
          DROP TABLE phrases_7;
          DROP TABLE phrases_8;
          DROP TABLE phrases_9;
        SQL
      end
    end
  end
end
