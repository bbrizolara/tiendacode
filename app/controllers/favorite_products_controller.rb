class FavoriteProductsController < ApplicationController
  before_action :product, :validate_uniqueness, only: %i[create]
  before_action :favorite_product, only: %i[destroy]

  def create    
    @favorite_product = FavoriteProduct.create(user: current_user, product: product)
    render_table
  end

  def destroy    
    product = favorite_product.product
    favorite_product.destroy
    render_table
  end

  private
  
  def product
    @product ||= Product.find(params.dig(:product_id))
  end

  def favorite_product
    @favorite_product ||= FavoriteProduct.find(params.dig(:id))
  end

  def favorite_product_params
    params.require(:favorite_product).permit(:id, :product_id)
  end

  def validate_uniqueness
    if FavoriteProduct.find_by(user: current_user, product: product)
      render_table
    end
  end

  def render_table
    render partial: 'favorite_products/favorites_table', layout: false 
  end
end
