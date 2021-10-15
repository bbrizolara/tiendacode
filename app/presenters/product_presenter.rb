class ProductPresenter < ApplicationPresenter
  def product_description
    if @model.description.length > 20
      "#{@model.description[0...20]...}"
    else
      @model.description
    end
  end
end
