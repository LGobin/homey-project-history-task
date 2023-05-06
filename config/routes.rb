# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root "projects#index"
  get "projects/:id/history", to: "projects#show", as: "project_history"
  resources :projects, only: :update
  resources :comments, only: :create
end
