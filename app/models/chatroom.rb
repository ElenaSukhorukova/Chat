class Chatroom < ApplicationRecord
  validates :chatroom_name, uniqueness: true, presence: true

  belongs_to :user
  has_many :messages, -> { sorted },  dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
end
