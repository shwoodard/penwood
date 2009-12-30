ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.signout 'signout', :controller => 'user_sessions', :action => 'destroy', :conditions => {:method => :get}
  map.resources :users, :collection => {:resend_activation_email => :get, :send_activation_email => :post}
  map.resource :account, :controller => 'users'
  map.activate_user 'account/:activation_code/activate', :controller => 'users', :action => 'activate', :conditions => {:method => :get}
  map.resources :testimonials
  map.resources :conversations
  
  map.with_options :controller => 'contact' do |contact|
    contact.contact 'contact', :action => 'index', :conditions => {:method => :get}
    contact.create_contact 'contact', :action => 'create', :conditions => {:method => :post}
  end
  
  map.with_options :controller => 'welcome' do |welcome|
    welcome.about_us 'about', :action => 'about_us', :conditions => {:method => :get}
  end
  
  map.namespace :admin do |admin|
    admin.root :controller => 'contents'
    admin.resources :contents, :collection => {:page => :get}
    admin.resources :testimonials, :member => {:move => :put}
    admin.resources :users
    admin.resources :groups
  end
  
  map.root :controller => "welcome"
end
