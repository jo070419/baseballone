class CreateAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :agreements do |t|
      t.boolean    :agreement_flag
      t.boolean    :cancel_flag, default: false
      t.references :user
      t.references :recruitment
      t.references :apply
      t.timestamps
    end
  end
end
