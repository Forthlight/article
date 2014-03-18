Rails.application.routes.draw do

  mount CommonDomain::Engine => "/common_domain"
end
