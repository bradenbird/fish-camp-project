class CreateEvaluations < ActiveRecord::Migration[5.1]
  def change
    create_table :evaluations do |t|
      t.references :chair, foreign_key: true, null: false
      t.references :applicant, foreign_key: true, null: false
      t.string :rating

      t.timestamps
    end
  end
end
