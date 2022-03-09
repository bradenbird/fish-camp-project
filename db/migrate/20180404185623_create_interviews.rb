class CreateInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :interviews do |t|
      t.references :chair, foreign_key: true, null: false
      t.references :applicant, foreign_key: true, null: false
      t.text :transcript

      t.timestamps
    end
  end
end
