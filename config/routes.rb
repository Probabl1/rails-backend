Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :products do
    collection do
      get 'by_category', to: 'products#index'
    end
  end

  resources :users do
    resource :cart, only: [:show] do
      post 'add_item', to: 'carts#add_item'
      delete 'remove_item/:product_id', to: 'carts#remove_item'
      delete 'clear', to: 'carts#clear'
    end
    resources :orders
  end
end
