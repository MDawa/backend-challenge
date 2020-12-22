Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :members, defaults: {format: "json"} do 
      member do
        get :search
      end
    end
  end
end
