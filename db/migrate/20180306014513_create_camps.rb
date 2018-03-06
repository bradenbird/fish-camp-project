class CreateCamps < ActiveRecord::Migration[5.1]
  def change
    create_table :camps do |t|
      t.string :name, null: false
      t.references :session, null: false
      t.timestamps null: false
    end
  end
end
