require 'rails_helper'

RSpec.describe Billboard do
  context "validation tests" do
    it "ensures address is present" do
      billboard = Billboard.new(photo: "image")
      expect(billboard.valid?).to eq(false)
    end
    it "should be able to save billboard" do
      billboard = Billboard.new(photo: "image",address: "Some text")
      expect(billboard.save).to eq(true)
    end

  end
  context " method tests" do
    it "should return Minsk address" do
    billboard = Billboard.new(photo: "image",address: "Some text")
    expect(billboard.get_full_address).to eq("Some text, Минск")
    end

  end

end













