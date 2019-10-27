Rails.application.routes.draw do
  # devise_for :users
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
        confirmations: 'confirmations'
    }
    root 'billboards#index', as: 'home'
    resources :billboards
    resource :profile
  end
end
