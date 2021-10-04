class ErrorsController < ApplicationController
  before_action :status_code, only: %i[show]

  def show; end  

  def not_found
    @status_code = 404
    flash[:error] = 'Page not found'
    render :show
  end

  def internal_error
    @status_code = 500
    flash[:error] = 'Something went wrong'
    render :show
  end

  private

  def status_code
    @status_code = params.dig(:id)|| 500
  end

  def error_params
    params.permit(:id)
  end
end
