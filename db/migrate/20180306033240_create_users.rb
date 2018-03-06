class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :google_uid
      t.string :uin
      t.string :name
      t.string :email
      t.string :role
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
