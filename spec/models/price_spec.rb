require 'rails_helper'

RSpec.describe Price do
  context "validation tests" do
    it "ensures billboard_id is present" do
      price = Price.new(price: 100)
      expect(price.valid?).to eq(false)
    end

    it "ensures price is present" do
      price = Price.new(billboard_id: 1)
      expect(price.valid?).to eq(false)
    end
    it "ensures price is greater than 0" do
      price = Price.new(billboard_id: 1,price: -1)
      expect(price.valid?).to eq(false)
    end
    it "should be able to save price" do
      price = Price.new(billboard_id: 1,price: 1)
      expect(price.save).to eq(true)
    end
  end


end













