# encoding: utf-8
class Wearther < Base
  match /^[zurg].+como.+tempo.+em\s(.+)[?]$/, :use_prefix => false, :method => :weather

  def initialize(*args)
    super
    GeoPlanet.appid = ENV['YAHOO_APP_ID']
  end

  def weather(m, location)
    results = GeoPlanet::Place.search(location)
    if results.any?
      city = results.first
      result = Weatherman::Client.new.lookup_by_woeid(city.woeid)
      if result.document_root.to_s =~ /Error/
        m.reply "Infelizmente rolou algum erro na sua solicitação.", true
      else
        m.reply "Está fazendo em #{result.location["city"]}, #{result.condition["temp"]} °C", true
      end
    else
      m.reply "Não existe esse lugar cara", true
    end
  end
end
