class UsersController < ApplicationController
  include UserHelper  
  before_action :verifiy_user_show, :user, only: %i[show]
  before_action :verify_access, only: %i[index]
  before_action :verify_user_new, only: %i[new]

  def index
    @users = User.where(active: true).order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    activation_token = new_token()
    create_activation_digest(activation_token)
    if user.save
      send_activation_email(activation_token)
      flash.now[:notice] = "Check your email to activate your account"
      redirect_to new_session_path
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

    def create_activation_digest(activation_token)      
      user.activation_digest = digest(activation_token)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def send_activation_email(activation_token)
      UserMailer.account_confirmation(user, activation_token).deliver_later
    end
end
