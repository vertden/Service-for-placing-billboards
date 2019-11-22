require 'rails_helper'

RSpec.describe User do
  # validation tests is not necessary(validates by devise)
  #

  context "method tests" do
    it "should make admin" do
      user = User.first
      expect(user.make_admin).to eq(true)
      expect(user.admin).to eq(true)
    end
    it "should remove admin" do
      user = User.first
      expect(user.remove_admin).to eq(true)
      expect(user.admin).to eq(false)
    end

  end

end













