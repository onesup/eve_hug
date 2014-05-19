Rails.application.routes.draw do
  namespace :mobile do
  get 'comments/new'
  end

  namespace :admin do
    get '/' => 'dashboard#index'
    resources :traffic_logs do
      member do
        get 'logs'
      end
    end
    resources :users
    resources :viral_actions do
      collection do
        get 'users'
      end
    end
    resources :daily_cards
    resources :comments do
      member do
        put 'set_cherry_picker'
      end
    end    
    resources :channels
  end

  namespace :fb do
    post 'create' => 'home#create'
    get 'index' => 'home#index'
    resources :users
  end
  
  namespace :pc do
    get 'index' => 'home#index'
    resources :comments
  end
  
  namespace :mobile do
    get 'index' => 'home#index'
    get 'personal_info' => 'home#popup_personal'
    get 'message' => 'home#popup_message'
    get 'show' => 'home#popup_show'
    get 'thanks' => 'home#popup_thanks'
    resources :comments, only: [:new, :create]
  end
  
  resources :viral_actions

  get 'web_switch' => 'web_switch#index'
  get 'fb_switch' => 'fb_switch#index'
  get 'user_signed_in' => 'user_sessions#user_signed_in'
  get 'event_finish' => 'web_switch#event_finish'
  
  devise_for :users, path: '/', :controllers => {:omniauth_callbacks => "callbacks"}
  root 'fb_switch#index'
end
