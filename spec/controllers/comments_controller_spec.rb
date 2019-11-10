require 'rails_helper'

RSpec.describe BillboardsController, type: :controller do
  let(:billboard) { Billboard.first }
  context "#authentication" do
    it "should redirect to authenticate page" do
      get :new
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      post :create, params: {comment: {nickname: "Some text",
                                       body: "Some text"},
                             billboard_id: 1}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
  end
end

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