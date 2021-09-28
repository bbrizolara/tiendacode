# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  describe "GET #index" do
    let!(:products) { FactoryBot.create_list(:product, 3) }
    subject { get :index }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to render_template("index") }
  end

  describe "GET #show" do
    let!(:product) { create(:product) }
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
    let(:attributes_prod) { FactoryBot.attributes_for(:product) }
    let(:params) do
      ActionController::Parameters.new(attributes_prod.merge(new_price))
                                  .permit(:name, :description, :price)
    end
    let(:product) { FactoryBot.build(:product, params.to_h) }

    it 'should create a product with given attributes' do
      expect(Product).to receive(:new).with(params).and_return(product)
      subject
    end

  end

  describe "GET #edit" do
    let(:product) { create(:product) }
    subject { get :edit, params: { id: product.id } }

    it { expect(response).to have_http_status(:success) }
    it { is_expected.to render_template("edit") }
  end

  describe "PUT #update" do
    subject { put :update, params: { id: product.id, product: new_params } }
    let!(:product) { FactoryBot.create(:product) }
    let(:new_attributes_prod) { FactoryBot.attributes_for(:product) }
    let(:new_params) do
      ActionController::Parameters.new(new_attributes_prod)
                                         .permit(:name, :description, :price)
    end 
    
    it "should update a Product with given params" do      
      subject
      product.reload
      expect(product.name).to eq(new_params[:name])
      expect(product.description).to eq(new_params[:description])
      expect(product.price).to eq(new_params[:price])
      is_expected.to redirect_to(action: :show, id: product.id)
    end
  end

  describe "DELETE #destroy" do
    let!(:product) { create(:product) }
    subject { delete :destroy, params: { id: product.id } }

    it "should delete a Product" do
      subject
      is_expected.to redirect_to(action: :index)
      expect{ product.reload }.to raise_error(ActiveRecord::RecordNotFound)      
    end
  end
end
