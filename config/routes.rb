Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'dashboard#index'
  get 'dashboard/index'
  get 'dashboard/conference_events'

  devise_for :users
  resources :conference_rooms do
    member do
      get :book_room
      post :booked_room
      get :cancle_booking
    end
    collection do
      get :rooms_booked_by_user
    end
  end
  resources :holidays
end
