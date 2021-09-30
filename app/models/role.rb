class Role < ApplicationRecord
  has_many :users

  def self.find_or_create(role_name)
    return Role.find_or_create_by(name: role_name)
  end
end
