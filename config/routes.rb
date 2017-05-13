Rails.application.routes.draw do
  resources :businesses do
    collection do
      get :search
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'businesses/index'
  root 'businesses#index'
  get 'businesses/search'
  post 'businesses/search'

end
