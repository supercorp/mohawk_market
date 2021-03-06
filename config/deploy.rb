before "deploy:cold", "config_files:create"
after "deploy:update_code", "deploy:pull_core_repo"
after "deploy:update_code", "config_files:symlink"
after "deploy:update", "deploy:cleanup"

set :stages, %w(dev staging production)
set :default_stage, "dev"

require 'capistrano/ext/multistage'
require 'erb'

set :application, "cc_mohawk"
set :user, "nobody"
set :runner, "nobody"
ssh_options[:paranoid] = false

set :repository,  "git@github.com:supercorp/mohawk_market.git"
set :core_repository, "git@github.com:supercorp/curated_commerce.git"
set :scm, :git
set :ssh_options, { :forward_agent => true }
set :use_sudo, false

set :keep_releases, 2

set (:deploy_to) { "/var/www/curatedcommerce/mohawk/#{stage}" }

desc "Modified deploy task for Phusion Passenger"
namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
    restart_workling
  end
  task :start, :roles => :app do
    # start task unnecessary for Passenger deployment
  end
  task :pull_core_repo, :roles => :app do
    run "cd #{release_path} && git remote add curated_commerce #{core_repository} && git pull curated_commerce #{branch}"
  end
end

desc "Restart Workling background server"
task :restart_workling, :roles => :app do
  stop_workling
  sleep 5
  start_workling
end

task :stop_workling, :roles => :app do
  run "cd #{release_path} && ./script/workling_client stop"
end
task :start_workling, :roles => :app do
  run "cd #{release_path} && ./script/workling_client start"
end

# Tasks for config files
namespace :config_files do
  desc "Create directories and config files: database.yml, mongrel_cluster.yml"
  task :create do
    make_directories
    database_yml
    local_config
    # pictures
  end

  desc "Prepate directory structure"
  task :make_directories do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/log" 
    run "mkdir -p #{shared_path}/public" 
    run "mkdir -p #{shared_path}/system" 
    run "mkdir -p #{deploy_to}/releases"     
  end

  desc "Make symlink for config files" 
  task :symlink do
    symlink_database_yml
    symlink_local_config
    # symlink_pictures
  end

  desc "Create database.yml in shared path" 
  task :database_yml do
    template = File.read(File.join(File.dirname(__FILE__), "deploy/templates", "database.erb"))
    result = ERB.new(template).result(binding)
    put result, "#{shared_path}/config/database.yml", :via => :scp
  end

  desc "Make symlink for database.yml" 
  task :symlink_database_yml do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end

  task :mailer_config do
    template = File.read(File.join(File.dirname(__FILE__), "deploy/templates", "mailer_config.erb"))
    result = ERB.new(template).result(binding)
    put result, "#{shared_path}/config/mailer_config.rb", :via => :scp
  end
  
  desc "Make symlink for mailer_config.rb" 
  task :symlink_mailer_config do
    run "ln -nfs #{shared_path}/config/mailer_config.rb #{release_path}/config/initializers/mailer_config.rb" 
  end

  task :local_config do
    run "touch #{shared_path}/config/local_config.rb"
  end

  desc "Make symlink for local_config.rb" 
  task :symlink_local_config do
    run "ln -nfs #{shared_path}/config/local_config.rb #{release_path}/config/initializers/local_config.rb" 
  end
  # desc "Create picture directories in shared path" 
  # task :pictures do
  #   run "mkdir -p #{shared_path}/public/pictures" 
  # end

  # desc "Make symlinks for pictures" 
  # task :symlink_pictures do
  #   run "rm -rf #{release_path}/public/pictures" 
  #   run "ln -nfs #{shared_path}/public/pictures #{release_path}/public/pictures" 
  # end
end

#role :app, "your app-server here"
#role :web, "your web-server here"
#role :db,  "your db-server here", :primary => true