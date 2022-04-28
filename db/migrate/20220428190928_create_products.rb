class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :brand
      t.float :price_bought
      t.float :shipping_price
      t.float :sales_tax
      t.float :price_sold
      t.float :shipping_fee
      t.float :additional_fees
      t.float :expenses
      t.float :profit
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
