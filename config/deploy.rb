require 'bundler/capistrano'

set :application, "easy-trip"
set :user, "root"
set :use_sudo, false
set :ssh_options, {:keys => [File.join(ENV["HOME"], ".ssh", "id_rsa.rea-ec2")]}

set :scm, :git
set :repository, "git@git.realestate.com.au:charley-wang/easy-trip.git"
set :deploy_via, :remote_cache
set :deploy_to, "/opt/hackday/#{application}"

role :app, "easy-trip.casa-cloud.vpc.realestate.com.au"

set :runner, user
set :admin_runner, user

namespace :deploy do
  task :start, :roles => :app do
    run "/etc/init.d/httpd start"
  end

  task :stop, :roles => :app do
    run "/etc/init.d/httpd stop"
  end

  task :restart, :roles => :app do
    deploy.stop
    deploy.start
  end

  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.stop
    deploy.update
    deploy.start
  end
end

namespace :fake_service do
  task :start do
    run "cd #{deploy_to}/current/fake_service; bundle exec rackup -p 4567 -D -P ./fake_service.pid"
  end

  task :stop do
    run "cd #{deploy_to}/current/fake_service; cat fake_service.pid | xargs kill -9"
  end
end