class AccountActivationsController < ApplicationController
  before_action :user, only: %i[edit]

  def edit
    account_activated = false
    if !user.active? && authenticated?(params.dig(:id))      
      user.activate
      log_in user
      account_activated = true      
    end
    handle_redirect(account_activated)
  end

  private

  def user
    @user ||= User.find_by(email: params.dig(:email))
  end

  def handle_redirect(account_activated)
    if account_activated
      flash[:notice] = "Account activated successfully"
    else
      flash[:alert] = "Invalid activation link"
    end    
    redirect_to root_path
  end

  def authenticated?(token)
    digest = user.activation_digest
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end
end
