Rails.application.routes.draw do
  # devise_for :users
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: {
        confirmations: 'confirmations'
    }
    root 'billboards#index', as: 'home'
    resources :billboards, only: [:show] do
      resources :billboard_employments
      resources :comments
    end
    scope '/admin' do
      resources :billboards, except: [:show, :index]
      resource :admin do
        member do
          get 'preview'
        end
      end
    end
    resource :profile
  end
end
