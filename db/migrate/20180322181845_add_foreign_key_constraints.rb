class AddForeignKeyConstraints < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :camps, :sessions
    add_foreign_key :chairs, :camps
    add_foreign_key :chairs, :users
    add_foreign_key :evaluations, :applicants
    add_foreign_key :evaluations, :chairs
    add_foreign_key :session_availabilities, :applicants
    add_foreign_key :session_availabilities, :sessions
  end
end
