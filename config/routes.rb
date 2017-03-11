Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Sidekiq::Web => '/sidekiq'
  get '/problems' => 'problems#index', as: 'problems'
  get '/problems/:pcode' => 'problems#problem', as: 'problem'
  post '/submit/' => 'submission#verify_submission', as: 'submit'
  get 'get_submission/:submission_id' => 'submission#get_submission', as: 'get_submission'
end
