Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "main#index"

  get "/index", to: "main#index"
  get "/nosotros", to: "main#about_us", as: :about_us
  get "/catalogo", to: "main#catalog", as: :catalog
  get "/contacto", to: "main#contact", as: :contact

  get "/catalogo/:name", to: "main#single_product", as: :single_product

  resources :productos, controller: :products, as: :products do
    get "/producto", to: "products#show_product", on: :member, as: :show, format: :js
  end

end
