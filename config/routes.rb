Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :purchases
      resources :items
      resources :users
      resources :item_options
    end
  end
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
