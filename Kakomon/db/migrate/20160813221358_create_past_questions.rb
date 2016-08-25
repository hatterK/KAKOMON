class CreatePastQuestions < ActiveRecord::Migration
  def change
    create_table :past_questions do |t|
      t.string :subject, null: false
      t.string :kana
      t.string :teacher
      t.integer :views, null: false
      t.string :image, null: false

      t.references :exam_date, null: false

      t.timestamps null: false
    end

    add_index :past_questions, :exam_date_id
  end
end
