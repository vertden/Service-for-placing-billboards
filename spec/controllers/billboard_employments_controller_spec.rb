require 'rails_helper'

RSpec.describe BillboardEmploymentsController, type: :controller do
  context "#authentication" do
    it "should redirect to authenticate page" do
      get :new, params: {billboard_id: 1}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      post :create, params: {billboard_employment: {brand: "Some text",
                                                    body: "Some text",
                                                    adv_type: "commercial",
                                                    start_date: Date.tomorrow,
                                                    duration: 1},
                             billboard_id: 1}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      delete :destroy, params: {billboard_id: 1,id: 1}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
  end
end

RSpec.describe BillboardEmploymentsController, type: :controller do

  context " #new" do
    it "should render new page" do
      @user = User.last
      sign_in @user
      get :new, params: {billboard_id: 1}
      expect(response).to render_template("new")
    end
  end
  context " #create" do
    it "should redirect to home page" do
      @user = User.last
      sign_in @user
      post :create, params: {billboard_employment: {brand: "Some text",
                                                    body: "Some text",
                                                    adv_type: "commercial",
                                                    start_date: Date.tomorrow,
                                                    duration: 1},
                             user_id: @user.id,
                             billboard_id: 1}
      expect(response).to redirect_to(home_path)
    end
    it "should render new page" do
      @user = User.last
      sign_in @user
      post :create, params: {billboard_employment: {brand: "",
                                                    body: "",
                                                    adv_type: "",
                                                    start_date: Date.yesterday,
                                                    duration: -1},
                             user_id: @user.id,
                             billboard_id: 1}
      expect(response).to render_template("new")
    end
  end
  context " #destroy" do
    it "should be deleted" do
      @user = User.last
      sign_in @user
      employment = BillboardEmployment.new(brand: "Some text",
                                           body: "Some text",
                                           adv_type: "commercial",
                                           billboard_id: 1,
                                           start_date: Date.tomorrow,
                                           duration: 1,
                                           user_id: @user.id)
      employment.save
      delete :destroy, params: {billboard_id: 1, id: employment.id, user_id: @user.id}
      expect(response).to redirect_to(home_path)
    end
  end
end