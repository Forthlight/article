Article::Engine.routes.draw do
  get "publications/search" => "publications#search"
  resources :publications, only: [:index, :show]
end
