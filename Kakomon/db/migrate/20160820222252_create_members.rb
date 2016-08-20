class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name, null: false
      t.string :hashed_password, null: false
      t.integer :access_authority, null: false

      t.timestamps null: false
    end
  end
end
