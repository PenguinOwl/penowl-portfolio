Rails.application.routes.draw do
  resources :user_flags
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :projects

  get 'project/admin', to: 'projects#admin'
end
