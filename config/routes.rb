Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'sign_out', to: 'users#destroy'
  end

  root 'top#index'

  resources :card, except: :index do
    collection do
      get 'registration_done'
      get 'delete_done'
    end
    member do
      get 'buy'
      post 'pay'
    end
  end

  resources :users, only: [:index, :show] do
    collection do
      get 'sold_items'
      get 'edit_done'
    end
  end

  resources :addresses, only: [:edit, :update] do
    collection do
      get 'edit_done'
    end
  end

  resources :items do
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
      get 'post_done'
      get 'delete_done'
    end
  end
end
