require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
require 'uri'

db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/zurg')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

require 'models/message'
require 'plugins/lastfm'
require 'plugins/message_manager'
require 'plugins/twitter_logger'
require 'plugins/weather'
require 'plugins/brain'

ActiveRecord::Migrator.migrate('./migrations')
