roles = Role.create([{ name: 'Admin' }, { name: 'User' }])
users = User.create(name: 'Admin', email: 'bbrizolara@cds.com', password: 'password', 
                    password_confirmation: 'password', active: true, role: roles.first)

require "open-uri"
20.times do
  Product.create do |product|
    product.name = Faker::Name.name
    product.description = Faker::Commerce.department
    product.price = Faker::Number.decimal(l_digits: 2)
    product.image.attach({
      io: URI.open(Faker::LoremFlickr.image(size: "250x250")),
      filename: "#{Time.now.to_i}-random-image.jpeg"
    })
  end
end

10.times do
  User.create do |user|
    user.email = Faker::Internet.email
    user.name = Faker::Name.first_name
    user.password = 'password'
    user.password_confirmation = 'password'
    user.active = true
    user.role = roles.second
  end
end

10.times do
  User.create do |user|
    user.email = Faker::Internet.email
    user.name = Faker::Name.first_name
    user.password = 'password'
    user.password_confirmation = 'password'
    user.active = true
    user.role = roles.second
  end
end
