require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require
ENV["RACK_ENV"] = 'production'

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

require 'zorg'
require 'log'
require 'twitter_logger'
require 'lastfm'
require 'message'
require 'message_manager'

ActiveRecord::Migrator.migrate('./migrations')
