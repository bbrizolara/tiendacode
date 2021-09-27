# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :product, only: %i[ show edit ]

  def index
    @products = Product.order(created_at: :desc)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if product.save
      flash[:notice] = "Product was successfully created."
      redirect_to product
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if product.update(product_params)
      flash[:notice] = "Product was successfully updated."
      redirect_to product
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product.destroy
    flash[:notice] = "Product was successfully deleted."
    redirect_to action: :index
  end

  private
  
    def product
      @product ||= Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :image)
    end
end
