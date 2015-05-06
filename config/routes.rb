Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  resources :interest_tags, only: [:index]
  resources :skill_tags, only: [:index]
  get "recommended_projects" => "projects#recommended_projects",
    as: "recommended_projects"
  resources :projects
end
