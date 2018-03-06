class CreateSessionAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :session_availabilities do |t|
      t.references :session, null: false
      # TODO: add t.references :application later
      t.timestamps null: false
    end
  end
end
