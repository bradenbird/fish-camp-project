class RemoveSessionColumnsFromApplicants < ActiveRecord::Migration[5.1]
  def change
    remove_column :applicants, :session_A, :boolean
    remove_column :applicants, :session_B, :boolean
    remove_column :applicants, :session_C, :boolean
    remove_column :applicants, :session_D, :boolean
    remove_column :applicants, :session_E, :boolean
    remove_column :applicants, :session_F, :boolean
    remove_column :applicants, :session_G, :boolean
  end
end
