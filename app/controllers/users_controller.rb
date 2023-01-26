class UsersController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      remember(user) if params[:remember_me] == '1'
      redirect_to root_path, success: t('users.create.flash', user_name: @user.user_name)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to root_path, success: I18n.t('users.update.flash')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user!
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation, :old_password)
  end

end
