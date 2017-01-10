Rails.application.routes.draw do
  apipie
  # get 'home/index'
  get "/users/:user_id/teams"   => "teams#index"
  get "/users/:user_id/teams/:team_id/add_member"   => "teams#add_member"
  get "/users/:user_id/organization" => "teams#organization"

  get '/invite_form' => 'invites#invite_form'
  get '/team' => 'users#team'

  get '/set_photo' => 'users#set_photo'

  get '/you_were_removed' => 'home#you_were_removed'

  get '/dashboard' => 'home#dashboard'

  # called by mailgun
  post '/feedback_reply/:feedback_id' => 'replies#feedback_reply'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, path_names: {registration: 'role/:role'}#, skip: [:sessions, :registrations]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'



  #->Prelang (user_login:devise/stylized_paths)
  devise_scope :user do
  #   get    "login"   => "users/sessions#new",         as: :new_user_session
  #   post   "login"   => "users/sessions#create",      as: :user_session
  #   delete "signout" => "users/sessions#destroy",     as: :destroy_user_session

    # get    "signup/:role"  => "users/registrations#new",    as: :new_user_registration
    # post   "signup/:role"  => "users/registrations#create", as: :user_registration
  #   put    "signup"  => "users/registrations#update", as: :update_user_registration
  #   # get    "account" => "users/registrations#edit",   as: :edit_user_registration

    get   "invite_email_signup/:role/:id" => "users/registrations#invite_email_signup", :as => :invite_email_registration
  end

  resources :users do
    resources :goals do
      post 'sign_off' => 'goals#sign_off'
      post 'approve' => 'goals#approve'
    end
    resources :feedbacks do
      get 'reply' => 'feedbacks#reply'
      resources :replies
    end
  end


  resources :invites do
    post 'resend' => 'invites#resend'
  end


end
