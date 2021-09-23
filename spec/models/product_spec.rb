require 'rails_helper'

RSpec.describe Product, :type => :model do
    context 'validate product' do
        it 'should be valid' do
            product = Product.new(name: 'prod', description: 'desc', price: 200)
            expect(product).to be_valid
        end

        it 'should not be valid' do
            product = Product.new(name: 'prod', description: 'desc')
            expect(product).to_not be_valid
        end
    end
end
