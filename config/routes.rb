ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.signout 'signout', :controller => 'user_sessions', :action => 'destroy', :conditions => {:method => :get}
  map.resources :users, :collection => {:resend_activation_email => :get, :send_activation_email => :post}, :except => [:new]
  map.resource :account, :controller => 'users'
  map.activate_user 'account/:activation_code/activate', :controller => 'users', :action => 'activate', :conditions => {:method => :get}
  map.resources :testimonials
  map.resources :conversations, :collection => {:list => :get}, :member => {:new_quick_note => :get}, :as => "dialogues"
  map.resources :appointments
  map.resources :articles, :only => [:index, :show], :as => 'readings'
  map.resources :payments

  map.with_options :controller => 'services' do |services|
    services.services 'services', :action => 'couples', :conditions => {:method => :get}
    services.couples_services 'services/couples', :action => 'couples', :conditions => {:method => :get}
    services.organizations_services 'services/organizations', :action => 'organizations', :conditions => {:method => :get}
    services.families_services 'services/families', :action => 'families', :conditions => {:method => :get}
  end
  
  map.with_options :controller => 'contact' do |contact|
    contact.contact 'contact', :action => 'index', :conditions => {:method => :get}
    contact.create_contact 'contact', :action => 'create', :conditions => {:method => :post}
  end
  
  map.with_options :controller => 'welcome' do |welcome|
    welcome.about_us 'about', :action => 'about', :conditions => {:method => :get}
    welcome.welcome_dialog 'welcome_dialog', :action => 'welcome_dialog', :conditions => {:method => :get}
    welcome.dont_show_welcome_dialog 'welcome_dialog', :action => 'dont_show_welcome_dialog', :conditions => {:method => :put}
  end
  
  map.namespace :admin do |admin|
    admin.root :controller => 'contents'
    admin.resources :contents, :collection => {:page => :get}
    admin.resources :testimonials, :member => {:move => :put}
    admin.resources :users, :member => {:ban => :put}, :except => [:destroy]
    admin.resources :groups
    admin.resources :image_slide_shows, :as => 'image_experiences'
    admin.resources :quotes
    admin.resources :articles
    admin.with_options :controller => 'calendar' do |cal|
      cal.calendar 'calendar', :action => 'index', :conditions => {:method => :get}
      cal.google_call_login_callback 'calendar/do_login', :action => 'login', :conditions => {:method => :get}
    end
  end
  
  map.root :controller => "welcome"
end
