class CreateChairs < ActiveRecord::Migration[5.1]
  def change
    create_table :chairs do |t|
      t.references :user, null: false
      t.references :camp
      t.timestamps null: false
    end
  end
end
