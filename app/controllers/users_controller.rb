class UsersController < ApplicationController
  include SessionsHelper
  before_action :user, only: %i[show]
  before_action :verify_access, only: %i[index]

  def index
    @users = User.order(created_at: :desc)
  end

  def show
    redirect_to unauthorized_index_path unless current_user.admin? || current_user.id == user.id
  end

  def new
    redirect_to root_path if logged_in? && !admin_logged?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if user.save
      log_in user
      flash.now[:notice] = "User was successfully created."
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  
    def user
      @user ||= User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
