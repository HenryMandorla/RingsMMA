Rails.application.routes.draw do
  devise_for :users
  get "forum_posts/index"
  get "forum_posts/show"
  get "forum_posts/new"
  get "forum_posts/create"
  get "forum_posts/edit"
  get "forum_posts/update"
  get "forum_posts/destroy"
  # Define routes for attendances (you might want more actions later)
  resources :attendances, only: [:index, :new, :create, :show]
  resources :gym_classes do
    member do
      post :add_learning
    end
  end
  resources :forum_posts do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:show, :edit, :update] do
    member do
      patch :update_belt_level
    end
  end

  # You'll likely add resources for users and gym_classes too
  # resources :users
  # resources :gym_classes

  # Set a root path, e.g., the attendance log page
  root "gym_classes#index"

  # Define other routes as needed
  resources :leaderboards, only: [:index]
end