# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    let!(:products) { FactoryBot.create_list(:random_product, 3) }
    before { get :index }

    it { expect(response).to have_http_status(:success) }
    it { expect(assigns(:products)).to_not be_empty }
    it { should render_template("index") }
  end

  describe "GET #show" do
    let!(:product) { create(:random_product) }
    subject { get :show, params: { id: product.id } }

    it { is_expected.to have_http_status(:success) }
    it { should render_template("show") }
    it "should be a Product" do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to be_a(Product)
    end
  end

  describe "GET #new" do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
    it { should render_template("new") }
    it { expect(assigns(:product)).to be_a(Product) }
    it { expect(assigns(:product)).to be_a_new(Product) }
  end

  describe "POST #create" do
    subject { Product }

    let(:params) do
      ActionController::Parameters.new(FactoryBot.attributes_for(:random_product))
      .permit(:name, :description, :price, :image)
    end
    let(:product) { FactoryBot.build(:random_product, params.to_h) }

    it "should create a Product with given params" do
      params[:price] = params[:price].to_s
      is_expected.to receive(:new).with(params).and_return(product)

      post :create, params: { product: params }
      expect(response).to redirect_to(action: :show, id: assigns(:product).id)
    end

    it "should not create a Product with given params" do
      params[:name] = nil
      post :create, params: { product: params }
      expect(response).to render_template("new")
      expect(response).to_not have_http_status(:success)
    end
  end

  describe "GET #edit" do
    let(:product) { create(:random_product) }
    subject { get :edit, params: { id: product.id } }

    it { expect(response).to have_http_status(:success) }
    it { should render_template("edit") }
    it "should be a Product" do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to be_a(Product)
    end
  end

  describe "PUT #update" do
    subject { Product }

    let(:params) do
      ActionController::Parameters.new(FactoryBot.attributes_for(:random_product))
      .permit(:name, :description, :price, :image)
    end
    let!(:product) { FactoryBot.create(:random_product, params.to_h) }

    it "should update a Product with given params" do
      params[:price] = params[:price].to_s
      params[:name] = "Updated name"
      put :update, params: { id: product.id, product: params }
      product.reload
      expect(product.name).to eq(params[:name])
      expect(response).to redirect_to(action: :show, id: assigns(:product).id)
    end

    it "should not update a Product" do
      params[:price] = params[:price].to_s
      params[:name] = nil
      put :update, params: { id: product.id, product: params }
      expect(response).to render_template("edit")
      expect(response).to_not have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    let(:product) { create(:random_product) }
    subject { get :destroy, params: { id: product.id } }

    it "should delete a Product" do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(action: :index)
    end
  end
end
