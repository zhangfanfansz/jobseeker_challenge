# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # root 'pages#index'

  # get 'pages/fonts_page' , to: 'pages#fonts_page'
  # get 'pages/spinners_page' , to: 'pages#spinners_page'
  # get 'pages/animations_page' , to: 'pages#animations_page'
  # get 'pages/global_notice_page', to: 'pages#global_notice_page'

  resources :template_models, controller: 'pages'
end
