# encoding: utf-8
class Brain < Base
  match /^zurg.+vida.+universo.+[?]$/, :use_prefix => false, :method => :life
  match /^(bot|zurg).+[^?!]$/i, :use_prefix => false, :method => :message
  match /help/, :method => :help

  def help(m)
    m.reply "Comandos:"
    m.reply "!help => retorna essa mensagem"
    m.reply "o que <user> anda fazendo no twitter? => Retorna os últimos 5 tweets do usuário"
    m.reply "o que <user> anda fazendo no lastfm? => Retorna as últimas 5 músicas do usuário"
    m.reply "mais informações sobre <banda>! => Retorna informações sobre a banda"
    m.reply "Mensagens:"
    m.reply "!message:add <mensagem> => Adiciona uma mensagem"
    m.reply "!message:list => Lista todas as mensagens"
    m.reply "!message:show <id> => Mostra uma determinada mensagem"
    m.reply "!message:destroy <id> => Apaga uma determinada mensagem"
    m.reply "!message:update <id> <mensagem> => Atualiza uma determinada mensagem"
  end

  def message(m)
    m.reply "#{m.user.nick}: #{random_message}" if Message.any?
  end

  def life(m)
    m.reply "#{m.user.nick}: A resposta para a pergunta fundamental sobra a vida, o Universo e tudo mais é 42."
  end

  private

  def random_message
    Message.where(:type_of_message => 'answer').order("RANDOM()").first.try(:content)
  end
end
