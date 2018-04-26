class ChangeDataTypeForTetanusBoosterField < ActiveRecord::Migration[5.1]
  def change
    change_column :applicants, :last_tetanus_booster_date, :string
  end
end
