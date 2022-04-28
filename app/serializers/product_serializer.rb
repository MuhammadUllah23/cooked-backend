class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand, :price_bought, :shipping_price, :sales_tax, :price_sold, :shipping_fee, :additional_fees, :expenses, :profit
  has_one :user
end
