class CreateAgreements < ActiveRecord::Migration[6.0]
  def change
    create_table :agreements do |t|
      t.boolean    :agreement_flag
      t.references :user
      t.references :recruitment
      t.timestamps
    end
  end
end
