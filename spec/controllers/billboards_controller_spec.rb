require 'rails_helper'

RSpec.describe BillboardsController, type: :controller do
  context "index action" do
    it "returns a success index response" do
      get :index
      expect(response).to be_successful
    end
  end

  context "show action" do
    let(:billboard) { Billboard.create(photo: "image", address: "Some text") }
    it "returns a success show response" do
      get :show, params: {id: billboard}
      expect(response).to be_successful
    end
    # it "renders 404 page if an item is not found" do
    #   get :show,params: {id: 0}
    #   expect(get :show,params: {id: 0}).to raise_error(ActiveRecord::RecordNotFound)
    # end
  end

  context "create action" do
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

end

