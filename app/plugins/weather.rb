# encoding: utf-8
class Wearther
  include Cinch::Plugin
  match /^zurg.+tempo.+180\sgraus[?]$/i, :use_prefix => false, :method => :weather_on_180, :group => :conversation
  match /^[zurg].+como.+tempo.+(em|no|na)\s(.+)[?]$/i, :use_prefix => false, :method => :weather, :group => :conversation

  def initialize(*args)
    super
    GeoPlanet.appid = ENV['YAHOO_APP_ID']
  end

  def weather(m, word, location)
    results = GeoPlanet::Place.search(location)
    if results.any?
      city = results.first
      result = Weatherman::Client.new.lookup_by_woeid(city.woeid)
      if result.document_root.to_s =~ /Error/
        m.reply "Infelizmente rolou algum erro na sua solicitação.", true
      else
        m.reply "Está fazendo #{result.condition["temp"]} °C #{word} #{result.location["city"]}", true
      end
    else
      m.reply "Não existe esse lugar cara", true
    end
  end

  def weather_on_180(m)
    m.reply "O tempo eu não sei, mas a pressão lá está só subindo", true
  end
end
