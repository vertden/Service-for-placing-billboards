require 'rails_helper'
RSpec.describe ProfilesController, type: :controller do
  context "#authentication" do
    it "should redirect to authenticate page" do
      get :show
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      get :edit
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      put :update, params: {profile: {first_name: "Some new text"}}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
  end
end
RSpec.describe ProfilesController, type: :controller do
  before(:each) do
    @user = User.first
    sign_in @user
  end
  context "#show" do
    it "returns a success show response" do
      get :show
      expect(response).to be_successful
    end
  end

  context "#edit" do
    it "should render edit page" do
      get :edit
      expect(response).to render_template("edit")
    end
  end

  context "#update" do
    it "should be update" do
      put :update, params: {profile: {first_name: "Some new text"}}
      expect(response).to redirect_to(profile_path)
    end
    it "should render edit page" do
      put :update, params: {profile:{address: "a"}}
      expect(response).to render_template("edit")
    end
  end

end

