# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  subject { build(:random_product) }
  
  describe "validate product" do
    it { is_expected.to be_a Product }
    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:image) }
  end
end
