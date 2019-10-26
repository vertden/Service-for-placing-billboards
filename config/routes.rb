Rails.application.routes.draw do
  # devise_for :users
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
        confirmations: 'confirmations'
    }
    resources :billboards
    root 'billboards#index', as: 'home'
  end
end
