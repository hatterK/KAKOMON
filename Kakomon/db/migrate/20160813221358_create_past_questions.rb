class CreatePastQuestions < ActiveRecord::Migration
  def change
    create_table :past_questions do |t|
      t.string :subject, null: false
      t.string :kana
      t.string :teacher
      t.reference :exam_date, null: false
      t.string :file_path, null: false
      t.date :added_time, null: false
      t.timestamps null: false
    end
  end
end
