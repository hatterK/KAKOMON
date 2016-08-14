class CreateExamDates < ActiveRecord::Migration
  def change
    create_table :exam_dates do |t|
      t.integer :year, null: false
      t.string :term, null: false

      t.timestamps null: false
    end
  end
end
