require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    # a mock method to be able to call index without route
    def index
      head :ok
    end
  end

  context "#set_locale method" do
    it "should return user locale" do
      @user = User.last
      sign_in @user
      get :index
      expect(I18n.locale).to eq(@user.language.to_sym)
    end
    it "should return en locale" do
      get :index,params: {locale: "en"}
      expect(I18n.locale).to eq(:en)
    end
    it "should return ru locale" do
      get :index,params: {locale: "ru"}
      expect(I18n.locale).to eq(:ru)
    end
    it "should return default locale" do
      get :index
      expect(I18n.locale).to eq(I18n.default_locale)
    end
  end
end
