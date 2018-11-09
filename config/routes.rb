Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path: 'users'
  resources :users do
    resources :user_flags
  end
  resources :comment_threads, path: "/greddit" do
    member do
      get 'predestroy'
    end
    resources :comments do
      member do
        get 'predestroy'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :projects
end
