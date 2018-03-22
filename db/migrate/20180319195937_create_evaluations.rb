class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :chair, null: false
      t.references :applicant, null: false 
      t.string :rating

      t.timestamps
    end
  end
end
