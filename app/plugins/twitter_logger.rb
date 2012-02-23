# encoding: utf-8
class TwitterLogger
  include Cinch::Plugin
  match /^[zurg].+o que (.+) anda fazendo no twitter[?]$/i, :use_prefix => false

  def execute(m, nick)
    begin
      Twitter::user_timeline(nick)[0,5].map(&:text).each {|tweet| m.reply tweet, true }
    rescue Twitter::Error::NotFound
      m.reply "FFFUUU, usuário não encontrado.", true
    rescue 
      m.reply "Aconteceu algum erro, meu camarada.", true
    end
  end
end
