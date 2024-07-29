Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "orders#home"
  get "fragrance", to: 'fragrances#index', as: 'fragrances'
  get "fragrance/new", to: 'fragrances#new', as: 'new_fragrance'
  post "fragrance", to: 'fragrances#create', as: 'create_fragrance'
  get "fragrance/:id/edit", to: 'fragrances#edit', as: 'edit_fragrance'
  patch "fragrance/:id", to: 'fragrances#update', as: 'update_fragrance'
  delete 'fragrance/:id', to: 'fragrances#destroy', as: 'destroy_fragrance'
  # resource :fragrance, only: [:index, :show, :update, :destroy]

end
