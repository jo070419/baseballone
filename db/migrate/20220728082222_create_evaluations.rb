class CreateEvaluations < ActiveRecord::Migration[6.0]
  def change
    create_table :evaluations do |t|
      t.integer    :good,    default: 0
      t.integer    :usually, default: 0
      t.integer    :bad,     default: 0
      t.references :user,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
