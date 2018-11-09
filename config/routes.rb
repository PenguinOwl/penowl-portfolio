Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, path: 'users'
  resources :users do
    resources :user_flags
  end
  resources :comments, path: "/greddit" do
    collection do
      get 'root_new'
      post 'root_new', to: "comments#create_root"
    end
    member do
      get 'predestroy'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :projects
end
