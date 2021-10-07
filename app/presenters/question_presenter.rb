class QuestionPresenter < ApplicationPresenter
  def createdat_to_text
    return nil unless @model.created_at
    @model.created_at.strftime("%B %d, %Y")
  end

  def user_info
    return nil unless @model.user_name && @model.user_email
    "#{@model.user_name} - #{@model.user_email}"
  end
end
