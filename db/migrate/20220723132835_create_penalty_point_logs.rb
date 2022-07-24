class CreatePenaltyPointLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :penalty_point_logs do |t|
      t.integer :increase_decrease_value
      t.references :penalty_point, null: false, foreign_key: true
      t.timestamps
    end
  end
end
