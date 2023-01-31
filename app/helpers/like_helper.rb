# frozen_string_literal: true

module LikeHelper
  def heart(message, user)
    message.likes.find_by(user: user).present? ? '🧡' : '🤍'
  end

  def likes_count(message)
    message.likes_count ||= 0
  end
end
