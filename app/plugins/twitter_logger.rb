# encoding: utf-8
class TwitterLogger < Base

  match /^[zurg].+o que (.+) anda fazendo no twitter[?]$/i, :use_prefix => false

  def execute(m, nick)
    begin
      Twitter::user_timeline(nick)[0,5].map(&:text).each do |tweet|
        m.reply("#{m.user.nick}: #{tweet}")
      end
    rescue Twitter::Error::NotFound
      m.reply("#{m.user.nick}: FUUU, usuário não encontrado.")
    rescue 
      m.reply("#{m.user.nick}: Aconteceu algum erro, meu camarada.")
    end
  end
end
