# frozen_string_literal: true

require "open-uri"

FactoryBot.define do
  factory :product, class: Product do
    name { Faker::Name.name }
    description { Faker::Commerce.department }
    price { Faker::Number.decimal(l_digits: 2) }

    after :build do |product|
      product.image.attach({
        io: URI.open(Faker::LoremFlickr.image(size: "500x300")),
        filename: "#{Time.now.to_i}-random-image.jpeg"
      })
    end
  end
end
