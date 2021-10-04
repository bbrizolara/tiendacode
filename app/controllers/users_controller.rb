class UsersController < ApplicationController
  before_action :verifiy_user_show, :user, only: %i[show]
  before_action :verify_access, only: %i[index]
  before_action :verify_user_new, only: %i[new]

  def index
    @users = User.order(created_at: :desc)
  end

  def show; end

  def new
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
