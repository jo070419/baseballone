class DropCategories < ActiveRecord::Migration[6.0]
  def change
    drop_table :categories do |t|
      t.string :category_name
      t.timestamps
    end
  end
end
