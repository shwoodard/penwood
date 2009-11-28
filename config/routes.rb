ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'welcome' do |welcome|
    welcome.about_us 'about'
  end
  
  map.root :controller => "welcome"
end
