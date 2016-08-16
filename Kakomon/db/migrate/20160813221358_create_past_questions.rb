class CreatePastQuestions < ActiveRecord::Migration
  def change
    create_table :past_questions do |t|
      t.string :subject, null: false
      t.string :kana
      t.string :teacher
      t.string :file_path, null: false
      t.integer :views, null: false
      t.date :added_time, null: false

      t.references :exam_date, null: false

      t.timestamps null: false
    end

    add_index :past_questions, :exam_date_id
  end
end
