class Question < ApplicationRecord
  belongs_to :product
  belongs_to :user, optional: true
  validates :user_name, :question, presence: true
  validates :user_email, presence: true,
                         format: { with: Devise.email_regexp, message: 'Must be a valid email' }

  scope :registered_users, -> { where.not(user_id: nil) }
  scope :registered_users, -> { where(user_id: nil) } 
  scope :ordered_by_date, -> { reorder(created_at: :desc) }
end
