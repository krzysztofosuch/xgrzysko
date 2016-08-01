Rails.application.routes.draw do
  resources :players
  resources :matches do
    member do
      post 'set_stone'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do 
    controller :gameplay do 
      get 'get_state'
      post 'set_stone'
    end
  end
end
