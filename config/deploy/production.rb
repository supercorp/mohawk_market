require File.join(File.dirname(__FILE__),'..','..','db','fixture_manifest.rb')
role :app, "feltandwireshop.com"
role :web, "feltandwireshop.com"
role :db,  "feltandwireshop.com", :primary => true

set :db_user, "cc_mohawk"
set :db_pass, "sup3r"

set :branch, "production"
set :rails_env, "production"
set (:deploy_to) { "/var/www/feltandwireshop.com/#{stage}" }

desc "Export data to fixtures."
task :export_fixtures, :roles => :db do
  run("cd #{deploy_to}/current; rake db:export_fixtures RAILS_ENV=production")
  # for image_type in ['background_images','logo_images','packing_slip_images']
  #   get "#{deploy_to}/current/public/#{image_type}.tgz", File.join(File.dirname(__FILE__),'..','..','public',"#{image_type}.tgz")
  # end
  get "#{deploy_to}/current/public/system.tgz", File.join(File.dirname(__FILE__),'..','..','public','system.tgz')
  %x[mkdir #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak')}]
  %x[rm -rf #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak','*')}]
  %x[mv #{File.join(File.dirname(__FILE__),'..','..','db','fixtures','*')} #{File.join(File.dirname(__FILE__),'..','..','db','fixtures.bak')}]
  for fixture in FixtureManifest.list
    get "#{deploy_to}/current/db/fixtures/#{fixture.to_s}.yml", File.join(File.dirname(__FILE__),'..','..','db','fixtures',fixture.to_s + '.yml')
  end

end
