require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET products#index' do
    let!(:products) { FactoryBot.create_list(:product, 3) }
    subject { response.body }
    before { get root_path }

    it { is_expected.to render_template('products/index') }
    it 'shows products information' do
      products.each do |product|
         is_expected.to include(product.name)
      end
    end
  end

  describe 'GET products#show' do
    let(:product) { FactoryBot.create(:product) }
    subject { response.body }
    before { get product_path(product) }

    it { is_expected.to render_template('products/show') }
    it 'shows product attributes' do
      is_expected.to include(product.name)
      is_expected.to include(product.price.to_s)
      is_expected.to include( CGI.escapeHTML( product.description ) )
    end
  end
end
