class AccountActivationsController < ApplicationController
  include UserHelper
  
  before_action :user, only: %i[edit]

  def edit
    account_activated = false
    if user
      authenticated = authenticated?(:activation, params.dig(:id))
      if !user.active? && authenticated
        user.activate
        log_in user
        account_activated = true        
      end
    end
    if account_activated
      flash[:notice] = "Account activated successfully"
    else
      flash.now[:alert] = "Invalid activation link"
    end    
    redirect_to root_path
  end

  private

  def user
    user = User.find_by(email: params.dig(:email))
  end

  def authenticated?(attribute, token)
    digest = user.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
