Rails.application.routes.draw do
  
  root    'site#home' 

  get     '/about',           to: 'site#about'
  get     '/contact',         to: 'site#contact'
  get     '/help',            to: 'site#help'
  get     '/signup',          to: 'users#new'
  post    '/signup',          to: 'users#create'
  get     '/login',           to: 'sessions#new'
  post    '/login',           to: 'sessions#create'
  delete  '/logout',          to: 'sessions#destroy'
  get     '/accountdeleted',  to: 'account_deletions#show'

  resources                 :users
  resources                 :diaries
  resources                 :targets
  resources                 :tasks
  
  resources                 :account_activations, only: [:edit]
  resources                 :password_resets,     only: [:new, :create, :edit, :update]
  resources                 :account_deletions,   only: [:edit]
  
end
