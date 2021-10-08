# frozen_string_literal: true

class Product < ApplicationRecord
  has_one_attached :image
  has_many :questions, dependent: :destroy
  validates :name,
            :description,
            :price,
            :image,
            presence: true
end
