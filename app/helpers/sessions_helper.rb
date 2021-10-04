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
    forbidden_action
  end

  def admin_logged?
    return logged_in? && current_user.admin?
  end

  def verifiy_user_show
    return if admin_logged? || logged_in? && current_user.id == user.id
    forbidden_action
  end

  def verify_user_new
    return unless logged_in? && !admin_logged?
    redirect_root
  end

  private

  def forbidden_action
    redirect_to error_path(403), flash: { error: 'Forbidden action' }
  end

  def redirect_root
    redirect_to root_path
  end
end
