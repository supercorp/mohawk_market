# Be sure to restart your server when you modify this file

# Uncomment below to force Rails into production mode when
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.
  # See Rails::Configuration for more options.

  # Skip frameworks you're not going to use. To use Rails without a database
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

config.middleware.use "Rack::Honeypot", :input_name => "account_id", :class_name => "clarity", :input_value => 'Enter your account id'
  # Specify gems that this application depends on. 
  # They can then be installed with "rake gems:install" on new installations.
  # You have to specify the :lib option for libraries, where the Gem name (sqlite3-ruby) differs from the file itself (sqlite3)
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "RedCloth"
  config.gem 'tzinfo'
  config.gem 'uuid'
  config.gem 'json'
  config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gemcutter.org'
  config.gem 'gnumarcelo-campaigning', :lib => 'campaigning'
  config.gem 'httparty'
  config.gem 'nokogiri'
  config.gem 'unindentable'
  # Only load the plugins named here, in the order given. By default, all plugins 
  # in vendor/plugins are loaded in alphabetical order.
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.load_paths += %W(#{RAILS_ROOT}/config/branded/)
  config.load_paths += %W( #{ File.join( RAILS_ROOT, 'app', 'models', 'behaviors' ) } )
  config.load_paths += %W( #{ File.join( RAILS_ROOT, 'app', 'models', 'market_files' ) } )


  # Force all environments to use the same logger level
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Make Time.zone default to the specified zone, and make Active Record store time values
  # in the database in UTC, and return them converted to the specified local zone.
  # Run "rake -D time" for a list of tasks for finding time zone names. Comment line to use default local time.
  config.time_zone = 'UTC'

  # The internationalization framework can be changed to have another default locale (standard is :en) or more load paths.
  # All files from config/locales/*.rb,yml are added automatically.
  # config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
    :session_key => '_sample_market_session',
    :secret      => '049a9184f31acf2268db819db08dd9a97ffd4ead1c5ebc787fe3fcba903050a71e6a1ed2e6604f1d7e37331a05501095ff12b19919c6c0049c9a104aeb2eb92f'
  }

  # Use the database for sessions instead of the cookie-based default,
  # which shouldn't be used to store highly confidential information
  # (create the session table with "rake db:sessions:create")
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # Please note that observers generated using script/generate observer need to have an _observer suffix
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :user_observer
end
require 'csv'
require 'money'
require 'oembed'
require 'shellwords'
VIMEO = OEmbed::Provider.new("http://www.vimeo.com/api/oembed.xml",:xml)
VIMEO << "http://vimeo.com/*"
VIMEO << "http://*.vimeo.com/*"
VIDDLER = OEmbed::Provider.new("http://lab.viddler.com/services/oembed/",:xml)
VIDDLER << "http://*.viddler.com/*"
FLICKR = OEmbed::Provider.new("http://www.flickr.com/services/oembed/",:xml)
FLICKR << "http://*.flickr.com/*"     
OEmbed::Providers.register(VIMEO,VIDDLER,FLICKR)
