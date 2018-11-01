Rails.application.routes.draw do
  match 'file', to: 'items#create', via: [:post]
  match 'files', to: 'items#index', via: [:get]
  get 'files/:tag_list/:id', to: 'items#index'
  #resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
