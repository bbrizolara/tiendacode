class SessionsController < ApplicationController
  include SessionsHelper

  def new; end

  def create
    if user&.authenticate(params.dig(:session, :password))
      log_in user
      flash.now[:notice] = "Logged in successfully"
      redirect_to user
    else
      flash.now[:alert] = "Invalid credentials"
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
