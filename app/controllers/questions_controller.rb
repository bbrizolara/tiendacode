class QuestionsController < ApplicationController
  before_action :product, only: %i[create]

  def create    
    @question = product.questions.create(question_params)
    if @question.errors.full_messages.to_sentence.present?
      flash[:alert] = @question.errors.full_messages.to_sentence
    else
      flash[:notice] = 'Question added successfully'
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
end
