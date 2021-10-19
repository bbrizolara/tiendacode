class SessionsController < ApplicationController
  def new; end

  def create
    status = nil
    if user&.authenticate(params.dig(:session, :password))
      if user.active?
        log_in user      
        status = :logged_in
      else
        status = :not_activated
      end
    else
      status = :failed_login
    end
    handle_redirect(status)
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def user
    @user ||= User.find_by(email: params.dig(:session, :email).downcase)
  end

  def handle_redirect(action)
    case action
    when :logged_in
      flash.now[:notice] = "Logged in successfully."
      redirect_to root_path
    when :not_activated
      flash.now[:alert] = "Account not activated."
      render :new
    when :failed_login
      flash.now[:alert] = "Invalid credentials."
      render :new
    else      
      flash.now[:alert] = "Something went wrong. Please try again later."
      render :new
    end
  end
end
