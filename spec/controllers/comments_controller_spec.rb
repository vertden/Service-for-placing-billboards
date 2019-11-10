require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
  before(:each) do
    @user = User.last
    sign_in @user
  end
  context "#new" do
    it "should render new page" do
      j :new, params: {billboard_id: 1}
      expect(response).to be_successful
    end
  end

  context "#create" do
    it "should create comment" do
      j :create, params: {comment: {nickname: @user.nickname,
                                       body: "Some text"},
                             billboard_id: 1}
      expect(response).to be_successful
    end
  end
end