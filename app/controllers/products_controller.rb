class ProductsController < ApplicationController

    private

    def product_params
        params.require(:product).permit(:user_id, :name, :brand, :price_bought, :shipping_price, :sales_tax, :price_sold, :shipping_fee, :additional_fees, :expenses, :profit)
    end
end
