module FavoriteProductsHelper
  def user_has_favorites
    current_user.products.any?
  end

  def get_favorite_product(product)
    favorite_product = FavoriteProduct.find_by(user: current_user, product: product)
  end
end
