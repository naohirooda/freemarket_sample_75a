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

  resources :card
  resources :addresses, only: [:edit, :update]
  resources :users, only: :show
  resources :card
  get 'user_edit_done', to: 'users#edit_done'
  get 'address_edit_done', to: 'addresses#edit_done'
  get 'card_create_done', to: 'card#create_done'
  get 'card_destroy_done', to: 'card#destroy_done'

  resources :items do
    collection do
      get 'get_category_children', defaults: { fomat: 'json'}
      get 'get_category_grandchildren', defaults: { fomat: 'json'}
    end
  end
end
