Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
        confirmations: 'confirmations'
    }
    root 'billboards#index', as: 'home'
    resources :billboards do
      resources :billboard_employments
      resources :comments
    end
    resource :profile
    namespace :admin do
      # member do
      get 'billboards'
      get 'users'
      patch 'appoint_admin'
      patch 'remove_admin'
      patch 'confirm'
      # end
    end
  end
end
