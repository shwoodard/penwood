Penwood::Application.routes.draw do
  resource :user_sessions

  get '/signout' => "user_sesssions#destroy", :as => :signout

  resources :users, :except => :new do
    collection do
      get :resend_activa
      post :send_activation_email
      get :change_email
      get :change_password
      get :avatar
      put :show_welcome_dialog
      get :new_user_quick
    end
  end

  resource :account, :controller => 'users'

  get '/account/:activation_code/activate' => "users#activate", :as => :activate_user

  resources :testimonials
  resources :conversations do
    collection do
      get :list
    end
    
    member do
     get :new_quick_note
    end
  end

  resources :appointments do
    collection do
      get :tentative_appointments
      get :confirmed_appointments
    end
  end

  resources :articles, :only => [:index, :show]
  resources :payments, :only => [:new]

  controller :services do
    get "/services" => :index, :as => :services
    get "/services/couples" => :couples, :as => :couples_services
    get "/services/businesses" => :organizations, :as => :organizations_services
    get "/services/individuals" => :families, :as => :families_services
  end
  
  controller :contact do
    get '/contact' => :index, :as => :contact
    post '/contact' => :create, :as => :create_contact
  end
  
  controller :welcome do
    get '/about' => :about, :as => :about_us
    get '/welcome_dialog' => :welcome_dialog, :as => :welcome_dialog
    put '/welcome_dialog' => :dont_show_welcome_dialog, :as => :dont_show_welcome_dialog
    get '/sitemap' => :site_map, :as => :site_map
  end
  
  namespace :admin do
    resources :contents do
      collection do
        get :page
      end
    end

    resources :testimonials do
      member do
        put :move
      end
    end

    resources :users, :except => [:destroy] do
      member do
        put :ban
      end
    end

    resources :groups

    resources :image_slide_shows, :as => :image_experiences do
      resources :images do
        member do
          put :move
        end
      end
    end

    resources :quotes
    resources :articles do
      member do
        put :move
      end
    end

    controller :calendar do
      get '/calendar' => :index, :as => :calendar 
      get '/calendar/do_login' => :login, :as => :google_call_login_callback
    end

    root :to => 'contents#index'
  end
  
  root :to => "welcome#index"
end
