class AddIndexToFavoriteProducts < ActiveRecord::Migration[6.1]
  def change
    add_index :favorite_products, [:user_id, :product_id], unique: true
  end
end
