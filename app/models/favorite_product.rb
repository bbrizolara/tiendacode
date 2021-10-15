class FavoriteProduct < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :product, dependent: :destroy

  validates :user_id, uniqueness: { scope: :product_id }
end
