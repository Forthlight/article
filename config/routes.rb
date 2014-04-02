Article::Engine.routes.draw do
  resources :publications, only: [:index, :show]
end
