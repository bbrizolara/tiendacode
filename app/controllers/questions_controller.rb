class QuestionsController < ApplicationController
  before_action :product, only: %i[create]

  def create    
    @question = product.questions.create(handle_params)
    if @question.persisted?
      @question = nil
      flash.now[:notice] = 'Question added successfully'
    end    
    render 'products/show'
  end

  private
  
    def product
      @product ||= Product.find(params.dig(:product_id))
    end

    def question_params
      params.require(:question).permit(:user_email, :user_name, :question, :user_id)
    end

    def handle_params
      if logged_in?
        logged_in_params = { user_email: current_user.email,
                             user_name: current_user.name, 
                             user_id: current_user.id }
        question_params.merge(logged_in_params)
      else
        question_params
      end
    end
end
