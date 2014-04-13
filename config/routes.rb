Rails.application.routes.draw do
  namespace :admin do
    get '/' => 'dashboard#index'
    resources :traffic_logs
    resources :users do
    end
    resources :viral_actions 
    resources :daily_cards
    resources :comments
  end

  namespace :fb do
    post 'create' => 'home#create'
    get 'index' => 'home#index'
    resources :users
  end
  
  namespace :pc do
    get 'index' => 'home#index'
    resources :users do
      collection do
        get 'delete'
      end
    end
  end
  
  namespace :mobile do
    get 'index' => 'home#index'
    get 'personal_info' => 'home#popup_personal'
    get 'message' => 'home#popup_message'
    get 'show' => 'home#popup_show'
    get 'thanks' => 'home#popup_thanks'
    resources :users
  end
  
  resources :viral_actions

  get 'web_switch' => 'web_switch#index'
  get 'fb_switch' => 'fb_switch#index'

  root 'web_switch#index'

  # resources :users
  devise_for :users
end
