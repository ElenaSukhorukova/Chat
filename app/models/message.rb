class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :chatroom
  has_many :likes, dependent: :destroy

  scope :sorted, -> { order(:id)}
end
