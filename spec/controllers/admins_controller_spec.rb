require 'rails_helper'
RSpec.describe AdminsController, type: :controller do
  context "#authentication" do
    let(:user) {User.first}
    it "should redirect to authenticate page" do
      get :billboards
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      get :users
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to home page" do
      patch :appoint_admin, params: {user_id: user.id}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to home page" do
      patch :remove_admin, params: {user_id: user.id}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to home page" do
      patch :confirm, params: {user_id: user.id,
                               request_id: BillboardEmployment.first.id}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
  end
  context "#verify_user" do
    before(:each) do
      #first user is NOT admin
      @user = User.first
      sign_in @user
    end
    it "should redirect to home page" do
      get :billboards
      expect(response).to redirect_to("http://test.host/en")
    end
    it "should redirect to home page" do
      get :users
      expect(response).to redirect_to("http://test.host/en")
    end
    it "should redirect to home page" do
      patch :appoint_admin, params: {user_id: @user.id}
      expect(response).to redirect_to("http://test.host/en")
    end
    it "should redirect to home page" do
      patch :remove_admin, params: {user_id: @user.id}
      expect(response).to redirect_to("http://test.host/en")
    end
    it "should redirect to home page" do
      patch :confirm, params: {user_id: @user.id,
                               request_id: BillboardEmployment.first.id}
      expect(response).to redirect_to("http://test.host/en")
    end
  end
end
RSpec.describe AdminsController, type: :controller do
  before(:each) do
    #last user is admin
    @user = User.last
    sign_in @user
  end
  context "#billboards" do
    it "should render billboards page" do
      get :billboards
      expect(response).to render_template("billboards")
    end
  end

  context "#users" do
    it "should render users page" do
      get :users
      expect(response).to render_template("users")
    end
  end

  context "#appoint_admin" do
    it "should redirect to users_admin_path" do
      patch :appoint_admin, params: {user_id: @user.id}
      expect(response).to redirect_to(users_admin_path)
    end
  end

  context "#remove_admin" do
    it "should redirect to users_admin_path" do
      patch :remove_admin, params: {user_id: @user.id}
      expect(response).to redirect_to(users_admin_path)
    end
  end

  context "#confirm" do
    it "should redirect to billboards_admin_path" do
      patch :confirm, params: {user_id: @user.id,
                               request_id: BillboardEmployment.first.id}
      expect(response).to redirect_to(billboards_admin_path)
    end
  end

end

