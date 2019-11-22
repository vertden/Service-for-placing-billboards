require 'rails_helper'

RSpec.describe BillboardEmployment do
  context "validation tests" do
    it "ensures brand is present" do
      employment = BillboardEmployment.new(body: "Some text",
                                           start_date: Time.now,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.valid?).to eq(false)
    end
    it "ensures body is present" do
      employment = BillboardEmployment.new(brand: "Some text",
                                           adv_type: "Some text",
                                           billboard_id: 1,
                                           start_date: Date.tomorrow.to_s,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.valid?).to eq(false)
    end
    it "ensures adv_type is present" do
      employment = BillboardEmployment.new(brand: "Some text",
                                           body: "Some text",
                                           billboard_id: 1,
                                           start_date: Date.tomorrow.to_s,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.valid?).to eq(false)
    end
    it "ensures billboard_id is present" do
      employment = BillboardEmployment.new(brand: "Some text",
                                           body: "Some text",
                                           adv_type: "Some text",
                                           start_date: Date.tomorrow.to_s,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.valid?).to eq(false)
    end
    context "ensures start_date" do
      it "is present" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             duration: 1,
                                             user_id: 1)
        expect(employment.valid?).to eq(false)
      end
      it "be greater than current date" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             start_date: Date.yesterday.to_s,
                                             duration: 1,
                                             user_id: 1)
        expect(employment.valid?).to eq(false)
      end
    end
    context "ensures duration " do
      it "is present" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             start_date: Date.tomorrow.to_s,
                                             user_id: 1)
        expect(employment.valid?).to eq(false)
      end
      it "must be greater than 0" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             start_date: Date.tomorrow.to_s,
                                             duration: -1,
                                             user_id: 1)
        expect(employment.valid?).to eq(false)
      end
    end
    context "ensures user_id " do
      it "is present" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             start_date: Date.tomorrow.to_s,
                                             duration: 1)
        expect(employment.valid?).to eq(false)
      end
      it "must be greater than 0" do
        employment = BillboardEmployment.new(brand: "Some text",
                                             body: "Some text",
                                             adv_type: "Some text",
                                             billboard_id: 1,
                                             start_date: Date.tomorrow.to_s,
                                             duration: 1,
                                             user_id: -1)
        expect(employment.valid?).to eq(false)
      end
    end
    it "ensures active is null by default" do
      employment = BillboardEmployment.new(brand: "Some text",
                                           body: "Some text",
                                           adv_type: "Some text",
                                           billboard_id: 1,
                                           start_date: Date.tomorrow.to_s,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.active?).to eq(true)
    end
    it "should be able to save employment" do
      employment = BillboardEmployment.new(brand: "Some text",
                                           body: "Some text",
                                           adv_type: "commercial",
                                           billboard_id: 1,
                                           start_date: Date.tomorrow,
                                           duration: 1,
                                           user_id: 1)
      expect(employment.save).to eq(true)
    end
  end
end