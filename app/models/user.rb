class User < ApplicationRecord
  before_save { self.email = email.downcase }
  
  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: Devise.email_regexp, message: 'Must be a valid email' },
                    uniqueness: true
  
  has_secure_password
end
