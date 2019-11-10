require 'rails_helper'

#Billboard.first:
# address: 'Some text'
# photo: 'Some text'
# price_id: 1
#
# Price with id 1:
# billboard_id: 1
# price: 100
RSpec.describe BillboardsController, type: :controller do
  let(:billboard) { Billboard.first }
  context "#authentication" do
    it "should redirect to authenticate page" do
      get :new
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      post :create, params: {billboard: {photo: "image", address: "Some text"},
                             price: {price: 10}}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      get :edit, params: {id: billboard.id}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      put :update, params: {billboard: {address: "Some new text "},
                            id: billboard.id, price: {price: 100}}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
    it "should redirect to authenticate page" do
      delete :destroy, params: {id: billboard.id}
      expect(response).to redirect_to("http://test.host/users/sign_in")
    end
  end
end

RSpec.describe BillboardsController, type: :controller do
  before(:each) do
    @user = User.last
    sign_in @user
  end
  let(:billboard) { Billboard.first }
  context "#show" do
    it "returns a success show response" do
      get :show, params: {id: billboard}
      expect(response).to be_successful
    end
  end

  context "#index" do
    it "returns a success index response" do
      get :index
      expect(response).to be_successful
    end
  end

  context " #new" do
    it "should render new page" do
      @user = User.last
      sign_in @user
      get :new
      expect(response).to render_template("new")
    end
  end

  context "#create" do
    it "redirects to home if billboard save" do
      post :create, params: {billboard: {photo: "image", address: "Some text"},
                             price: {price: 10}}
      expect(response).to redirect_to(home_path)

    end
    it "renders new  page again if validations fail" do
      post :create, params: {billboard: {photo: "image"}}
      expect(response).to render_template("new")
    end
  end

  context "#edit" do
    it "should render edit page" do
      get :edit, params: {id: billboard.id}
      expect(response).to render_template("edit")
    end
  end

  context "#update" do
    it "should be update" do
      put :update, params: {billboard: {address: "Some new text "},
                            id: billboard.id, price: {price: 100}}
      expect(response).to redirect_to(home_path)
    end
    it "should render edit page" do
      put :update, params: {billboard: {address: ""},
                            id: billboard.id, price: {price: -1}}
      expect(response).to render_template("edit")
    end
  end

  context "#destroy" do
    it "should be deleted" do
      delete :destroy, params: {id: billboard.id}
      expect(response).to redirect_to(billboards_admin_path)
    end
  end
end

