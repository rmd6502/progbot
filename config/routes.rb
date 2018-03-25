Rails.application.routes.draw do
  post 'slack/search'

  post 'slack/project_search'

  post 'slack/project_skills_search'

  post 'slack/project_list'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'admin/dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
