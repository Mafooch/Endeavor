Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  get "projects/all_skills"
  get "projects/all_interests"
  get "recommended_projects" => "projects#recommended_projects",
    as: "recommended_projects"
  resources :projects
end
