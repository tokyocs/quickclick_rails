Rails.application.routes.draw do
  get 'play/:student_id', to: 'playground#index', as: 'play'
  root 'home#index', as: :top

  resources :reflections
  resources :answers
  resources :selections
  resources :estimates
  resources :problems do
      collection do
          get 'randomten'
          get 'randomfive'
          get 'experiment'
          post 'import'
      end
  end
  resources :students
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
