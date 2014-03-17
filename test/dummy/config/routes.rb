Rails.application.routes.draw do

  mount Article::Engine => "/article"
end
