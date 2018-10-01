Rails.application.routes.draw do

  root  'site#home' 

  get   '/about',         to: 'site#about'
  get   '/contact',       to: 'site#contact'
  get   '/help',          to: 'site#help'
  get   '/signup',        to: 'users#new'
  post  '/signup',        to: 'users#create'

  resources               :users
   
end
