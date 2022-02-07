Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to:  'search#questions'
    get 'subjct', to:  'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#questions'
  end
  
  namespace :users_backoffice do
    get 'welcome/index'
  end
  
  namespace :admins_backoffice do
    get 'welcome/index'   # Dashboard
    resources :admins     # Admininstradores 
    resources :subjects   # Assuntos/Aréas
    resources :questions  # Perguntas
  end

  devise_for :users, skip: [:registrations]
  devise_for :admins
  
  get 'welcome/index'
  
  get 'inicio', to:'site/welcome#index'

  root to:'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end