# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in user
      remember(user) if params[:remember_me] == '1'
      redirect_to root_path,
                  success: t('.flashes.welcome', user_name: user.user_name)
    else
      render :new, status: :unprocessable_entity
      flash.now[:warning] = t('.flashes.error')
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path, success: t('.flash')
  end
end
