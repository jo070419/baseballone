class CreatePenaltyPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :penalty_points do |t|
      t.integer :point
      t.references :user
      t.timestamps
    end
  end
end
