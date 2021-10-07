class SessionsController < ApplicationController
  def new; end

  def create
    msg = ''
    logged_in = false
    if user&.authenticate(params.dig(:session, :password))
      if user.active?
        log_in user      
        msg = "Logged in successfully"
        logged_in = true
      else
        msg = "Account not activated"
      end
    else
      msg = "Invalid credentials"
    end

    if logged_in
      flash.now[:notice] = msg
      redirect_to root_path
    else
      flash.now[:alert] = msg
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def user
    @user ||= User.find_by(email: params.dig(:session, :email).downcase)
  end
end
