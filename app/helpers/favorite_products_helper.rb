module FavoriteProductsHelper
  def user_has_favorites
    current_user.products.any?
  end
end
