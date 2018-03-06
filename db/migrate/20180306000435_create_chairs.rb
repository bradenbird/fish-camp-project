class CreateChairs < ActiveRecord::Migration[5.1]
  def change
    create_table :chairs do |t|
      # Reference User to get id for chair
      # use the uuid from google authentication
      # t.references :user, null: false
      t.references :camp
      t.timestamps null: false
    end
  end
end
