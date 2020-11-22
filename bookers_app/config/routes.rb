Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => "homes#about"
  resources :users, only: [:edit, :update, :create, :index, :show ]
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
