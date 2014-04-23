Article::Engine.routes.draw do
  
  get "publications/search" => "publications#search"

  post "publications/rate/:id" => "publications#rate", :as => "rate"

  resources :publications, only: [:index, :show] do
    resources :comments
  end

  resources :guide
end
