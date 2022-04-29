class ProductsController < ApplicationController

    def index
        @products = Product.all
        render json: @products
    end

    def show 
        @product = Product.find(params[:id])
        render json: @product
    end

    def create 
        @product = Product.new(product_params)
        if @product.save
            render json: :@product
        else
            render json: {message: "Make sure to correctly fill all inputs."}
        end
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: @product
        else
            render json: {message: "Make sure to correctly fill all inputs."}
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
    end

    private

    def product_params
        params.require(:product).permit(:user_id, :name, :brand, :price_bought, :shipping_price, :sales_tax, :price_sold, :shipping_fee, :additional_fees, :expenses, :profit)
    end
end
