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
    # it "ensures photo is null by default" do
    #   billboard = Billboard.new(photo: "image",address: "Some text")
    #   expect(billboard.photo?).to eq(false)
    # end
    # it "ensures price_id is null by default" do
    #   billboard = Billboard.new(photo: "image", address: "Some text")
    #   expect(billboard.price_id?).to eq(false)
    # end
    # it "ensures adv_type is null by default" do
    #   billboard = Billboard.new(photo: "image",address: "Some text")
    #   expect(billboard.adv_type?).to eq(false)
    # end
    # it "ensures brand is null by default" do
    #   billboard = Billboard.new(photo: "image",address: "Some text")
    #   expect(billboard.brand?).to eq(false)
    # end
    # it "ensures latitude is null by default" do
    #   billboard = Billboard.new(photo: "image",address: "Some text")
    #   expect(billboard.latitude?).to eq(false)
    # end
    # it "ensures longitude is null by default" do
    #   billboard = Billboard.new(photo: "image",address: "Some text")
    #   expect(billboard.longitude?).to eq(false)
    # end
  end
  context " method tests" do
    it "should return Minsk address" do
    billboard = Billboard.new(photo: "image",address: "Some text")
    expect(billboard.get_full_address).to eq("Some text, Минск")
    end

  end

end













