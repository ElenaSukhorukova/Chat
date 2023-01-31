# frozen_string_literal: true

class User < ApplicationRecord
  include Recoverable
  include Rememberable

  attr_accessor :old_password, :remember_token

  has_secure_password validations: false

  has_many :messages, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :chatroom, through: :chatroom_users

  validates :user_name, presence: true, length: { in: 3..15 }
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': { mx: true }
  validates :password, confirmation: true, allow_blank: true
  validate :password_presence
  validate :password_complexity
  validate :correct_old_password, on: :update

  private

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, I18n.t('activerecord.errors.models.user.attributes.password.incorrect')
  end

  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/

    errors.add :password, I18n.t('activerecord.errors.models.user.attributes.old_password.incorrect')
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end
end
