Rails.application.routes.draw do

  root    'site#home' 

  get     '/about',         to: 'site#about'
  get     '/contact',       to: 'site#contact'
  get     '/help',          to: 'site#help'
  get     '/signup',        to: 'users#new'
  post    '/signup',        to: 'users#create'
  get     '/login',         to: 'sessions#new'
  post    '/login',         to: 'sessions#create'
  delete  '/logout',        to: 'sessions#destroy'

  resources                 :users
  resources                 :diaries
  resources                 :targets
  resources                 :tasks

end
