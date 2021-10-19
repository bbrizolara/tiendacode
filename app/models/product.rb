# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  has_many :questions, dependent: :destroy
  has_many :favorite_products
  has_many :users, through: :favorite_products
  validates :name,
            :description,
            :price,
            :image,
            presence: true
end
