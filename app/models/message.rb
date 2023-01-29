class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :chatroom

  scope :sorted, -> { order(:id)}
end
