class Product < ApplicationRecord
  belongs_to :user
  validates_presence_of :id, :name, :brand, :price_bought, :shipping_price, :sales_tax, :price_sold, :shipping_fee, :additional_fees, :expenses, :profit
  validates_numericality_of :price_bought, :shipping_price, :sales_tax, :price_sold, :shipping_fee, :additional_fees, :expenses, :profit
end
