# frozen_string_literal: true

class MessagesController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :require_authentication

  def create
    @chatroom = Chatroom.find params[:chatroom_id]
    @user = current_user
    return unless ChatroomUser.exists?(user: @user, chatroom: @chatroom)

    @message = @user.messages.build message_params

    if @message.save
      @message.broadcast_append_to @chatroom, target: "#{dom_id(@chatroom)}_messages"
    else
      render_options
    end
  end

  def like
    @message = Message.find params[:id]
    @chatroom = @message.chatroom
    @user = current_user
    like = @message.likes.find_by(user: @user)

    like.present? ? like.destroy : @message.likes.create(user: @user)

    @message.broadcast_replace_to(
      [@user, @chatroom],
      target: "#{dom_id(@message)}_likes",
      locals: { message: @message, user: @user },
      partial: 'messages/heart'
    )

    @message.broadcast_replace_to(
      @chatroom,
      target: "#{dom_id(@message)}_likes_count",
      locals: { message: @message },
      partial: 'messages/likes_count'
    )
  end

  private

  def render_options
    @chatroom = Chatroom.find params[:chatroom_id]
    @users = @chatroom.users.order(:user_name)
    @message ||= @user.messages.build
    @messages = @chatroom.messages.includes(:user)
    render('chatrooms/show', status: :unprocessable_entity)
  end

  def message_params
    params.require(:message).permit(:body).merge(chatroom: @chatroom)
  end
end
