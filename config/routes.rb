Rails.application.routes.draw do
  root to: 'subjects#index'
  
  resources :sections
  resources :classrooms
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end
  resources :subjects
  resources :students, only: [:index, :show]
  post 'login_as/:id', to: 'sessions#login_as', as: 'login_as_student'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
