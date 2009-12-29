ActionController::Routing::Routes.draw do |map|
  map.resource :user_session
  map.resource :account, :controller => 'users'
  map.resources :users
  map.resources :testimonials
  
  map.with_options :controller => 'contact' do |contact|
    contact.contact 'contact', :action => 'index', :conditions => {:method => :get}
  end
  
  map.with_options :controller => 'welcome' do |welcome|
    welcome.about_us 'about', :action => 'about_us', :conditions => {:method => :get}
  end
  
  map.namespace :admin do |admin|
    admin.root :controller => 'contents'
    admin.resources :contents
    admin.resources :testimonials
  end
  
  map.root :controller => "welcome"
end
