class Chatroom < ApplicationRecord
validates :chatroom_name, presence: true

  belongs_to :user
  has_many :messages, -> { sorted },  dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users

  before_create { self.title = SecureRandom.hex(3) }
end
