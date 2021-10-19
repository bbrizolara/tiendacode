class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_validation :assign_role, unless: :persisted?

  belongs_to :role
  has_many :questions
  has_many :favorite_products
  has_many :products, through: :favorite_products
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: Devise.email_regexp, message: 'Must be a valid email' },
                    uniqueness: true
  
  has_secure_password
  

  def assign_role
    self.role ||= Role.find_or_create('User')
  end

  def admin?
    return role.name.eql? 'Admin'
  end
end
