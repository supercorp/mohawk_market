require File.join(File.dirname(__FILE__),'..','..','db','fixture_manifest.rb')
role :app, "mohawkdev.curatedcommerce.com"
role :web, "mohawkdev.curatedcommerce.com"
role :db,  "mohawkdev.curatedcommerce.com", :primary => true

set :db_user, "cc_mohawk"
set :db_pass, "sup3r"

set :branch, "master"

set :rails_env, "production"
before "deploy:wipe_and_load", "deploy"
namespace :deploy do  
  desc "Erase, rebuild, and populate database from schema.rb and fixture files."
  task :wipe_and_load, :roles => :db do
    run("cd #{deploy_to}/current; rake db:wipe_and_load RAILS_ENV=production")
    run("cd #{deploy_to}/shared; tar xzf ../current/public/system.tgz")
  end
end

desc "Export data to fixtures."
task :export_fixtures, :roles => :db do
  
  run("cd #{deploy_to}/current; rake db:export_fixtures RAILS_ENV=production")
  get "#{deploy_to}/current/public/system.tgz", File.join(File.dirname(__FILE__),'..','..','public','system.tgz')
  %x[mkdir #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak')}]
  %x[rm -rf #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak','*')}]
  %x[mv #{File.join(File.dirname(__FILE__),'..','..','db','fixtures','*')} #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak')}]
  for fixture in FixtureManifest.list
    get "#{deploy_to}/current/db/fixtures/#{fixture.to_s}.yml", File.join(File.dirname(__FILE__),'..','..','db','fixtures',fixture.to_s + '.yml')
  end
end
