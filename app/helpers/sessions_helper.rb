module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def verify_access
    return if logged_in? && current_user.admin?
    redirect_to error_path(403), flash: { error: 'Forbidden action' }
  end

  def admin_logged?
    return logged_in? && current_user.admin?
  end
end
