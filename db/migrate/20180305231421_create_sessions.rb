class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.timestamps null: false
    end
  end
end
