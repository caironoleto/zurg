$:.unshift(File.expand_path(File.dirname(__FILE__), "config"))
$:.unshift(File.expand_path(File.dirname(__FILE__), "app"))
require 'setup'

Cinch::Bot.new do
  configure do |c|
    c.server      = "irc.freenode.org"
    c.nick        = 'zurg'
    c.password    = ENV['IRC_PASSWORD']
    c.channels    = ["#gurupi"]
    c.plugins.plugins = [Lastfm, MessageManager, TwitterLogger, Wearther, Brain]
  end
end.start
