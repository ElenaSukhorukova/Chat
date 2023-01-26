class User < ApplicationRecord
  validates :user_name, presence: true
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': { mx: true }
  has_secure_password validations: false
end
