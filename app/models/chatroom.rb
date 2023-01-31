# frozen_string_literal: true

class Chatroom < ApplicationRecord
  validates :chatroom_name, uniqueness: true, presence: true

  belongs_to :user
  has_many :messages, -> { sorted }, dependent: :destroy, inverse_of: :messages
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
end
