class CreateTagRelations < ActiveRecord::Migration
  def change
    create_table :tag_relations do |t|
      t.references :past_question, null: false
      t.references :tag, null: false

      t.timestamps null: false
    end

    add_index :tag_relations, :past_question_id
    add_index :tag_relations, :tag_id
  end
end
