set :application, "penwood"
set :repository,  "git@github.com:shwoodard/penwood.git"
set :deploy_to, "/home/penwood/sites/corporate"

set :scm, :git

set :user, "penwood"
set :use_sudo, false
set :password, "penwd"
set :domain, "174.143.146.192"
server domain, :app, :web
role :db, domain, :primary => true

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'log','production.log')}"
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace(:customs) do
  task :config, :roles => :app do
    
  end
end

after "deploy:update_code", "customs:config"
after "deploy:update_code", "deploy:migrate"
after "deploy", "deploy:cleanup"