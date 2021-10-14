class FavoriteProductsController < ApplicationController
  include FavoriteProductsHelper
  before_action :product, :user, only: %i[create]
  before_action :favorite_product, only: %i[destroy]

  def create
    unless get_favorite_product(product)
      @favorite_product = FavoriteProduct.create(user: user, product: product)
    end
    render partial: 'favorite_products/favorites_table', locals: { product: product }, layout: false 
  end

  def destroy
    product = favorite_product.product
    favorite_product.destroy
    render partial: 'favorite_products/favorites_table', 
           locals: { product: product }, layout: false
  end

  private
  
    def product
      @product ||= Product.find(params.dig(:product_id))
    end

    def user
      @user ||= current_user
    end

    def favorite_product
      @favorite_product ||= FavoriteProduct.find(params.dig(:id))
    end

    def favorite_product_params
      params.require(:favorite_product).permit(:id, :product_id)
    end
end
