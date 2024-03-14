Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "main#index"

  get "/index", to: "main#index"
  get "/nosotros", to: "main#about_us", as: :about_us
  get "/catalogo/motos-electricas", to: "main#electric_motorcycles_catalog", as: :electric_motorcycles_catalog
  get "/catalogo/accesorios", to: "main#accessories_catalog", as: :accessories_catalog
  get "/contacto", to: "main#contact", as: :contact

  get "/catalogo/motos-electricas/:name", to: "main#single_product_electric_motorcycles", as: :single_product_electric_motorcycles
  get "/catalogo/accesorios/:name", to: "main#single_product_accessories", as: :single_product_accessories

  resources :productos, controller: :products, as: :products do
    get "/producto", to: "products#show_product", on: :member, as: :show, format: :js
    resources :imagenes, controller: :product_images, as: :images, only: [:new, :create, :destroy]
  end

  resources :accesorios, controller: :accessories, as: :accessories do
    get "/accesorio", to: "accessories#show_accessory", on: :member, as: :show, format: :js
    resources :imagenes, controller: :accessory_images, as: :images, only: [:new, :create, :destroy]
  end

  devise_for :users

end
