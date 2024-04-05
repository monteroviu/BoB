Rails.application.routes.draw do


  resources :invitations
  resources :questionnaires
  resources :schools do
    resources :groups do
      resources :students
    end
  end

  devise_for :users
  #devise_scope :user do
  # root to: "devise/sessions#new"
  #end
 get '/schools/:school_id/groups/upload-excel/:id', controller: 'groups', action: 'upload_excel', as: :new_school_group_excel

post '/schools/:school_id/groups/upload-excel/:id', controller: 'groups', action: 'procesar_excel', as: :procesar_excel


 get 'welcome/index'
 #root to: "devise/sessions#new"
 root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
