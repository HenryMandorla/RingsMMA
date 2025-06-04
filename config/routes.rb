Rails.application.routes.draw do
  devise_for :users

  root "gym_classes#index"

  # Forum Posts and Comments
  resources :forum_posts do
    resources :comments, only: [:create, :destroy]
  end

  # Attendances
  resources :attendances

  # Gym Classes with extra member route
  resources :gym_classes do
    member do
      post :add_learning
    end
  end

  # Users with belt level update
  resources :users, only: [:show, :edit, :update] do
    member do
      patch :update_belt_level
    end
  end

  # Leaderboards
  resources :leaderboards, only: [:index]
end
