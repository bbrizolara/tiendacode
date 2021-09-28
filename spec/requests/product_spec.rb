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
    let!(:product) { FactoryBot.create(:product) }
    let(:price_string) { product.price.to_s }
    let(:escaped_html_description) { CGI.escapeHTML(product.description) }
    let(:escaped_html_name) { CGI.escapeHTML(product.name) }
    subject { response.body }
    before { get product_path(product) }

    it { is_expected.to render_template('products/show') }
    it 'shows product attributes' do
      is_expected.to include(escaped_html_name)
      is_expected.to include(price_string)
      is_expected.to include(escaped_html_description)
    end
  end
end
