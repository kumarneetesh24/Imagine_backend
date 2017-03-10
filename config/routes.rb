Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/problems' => 'problems#index', as: 'problems'
  get '/problems/:pcode' => 'problems#problem', as: 'problem'
end
