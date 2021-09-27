# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    let!(:products) { FactoryBot.create_list(:random_product, 3) }
    before { get :index }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to render_template("index") }
  end

  describe "GET #show" do
    let!(:product) { create(:random_product) }
    subject { get :show, params: { id: product.id } }

    it { is_expected.to have_http_status(:success) }
    it { is_expected.to render_template("show") }
  end

  describe "GET #new" do
    before { get :new }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to render_template("new") }
    it { expect(assigns(:product)).to be_a_new(Product) }
  end

  describe "POST #create" do
    subject { post :create, params: { product: params } }

    let(:new_price) { { price: attributes_prod[:price].to_s } }
    let(:attributes_prod) { FactoryBot.attributes_for(:random_product) }
    let(:params) do
      ActionController::Parameters.new(attributes_prod.merge(new_price))
                                  .permit(:name, :description, :price)
    end
    let(:product) { FactoryBot.build(:random_product, params.to_h) }

    it 'should create a product with give attributes' do
      expect(Product).to receive(:new).with(params).and_return(product)
      subject
    end

  end

  describe "GET #edit" do
    let(:product) { create(:random_product) }
    subject { get :edit, params: { id: product.id } }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to render_template("edit") }
  end

  describe "PUT #update" do
    subject { put :update, params: { id: product.id, product: params } }

    let(:new_price) { { price: attributes_prod[:price].to_s } }
    let(:attributes_prod) { FactoryBot.attributes_for(:random_product) }
    let(:params) do
      ActionController::Parameters.new(attributes_prod.merge(new_price))
                                  .permit(:name, :description, :price)
    end
    let!(:product) { FactoryBot.create(:random_product, params.to_h) }
    it "should update a Product with given params" do
      
      params[:name] = "Updated name"
      subject
      product.reload
      expect(product.name).to eq(params[:name])
      expect(response).to redirect_to(action: :show, id: product.id)
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
