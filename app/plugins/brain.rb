# encoding: utf-8
class Brain
  include Cinch::Plugin

  match /help/, :method => :help
  match /^zurg.+vida.+universo.+[?]$/i, :use_prefix => false, :method => :life, :group => :conversation
  match /^zurg.+seu.+código[?]$/i, :use_prefix => false, :method => :repository, :group => :conversation
  match /^zurg.+leis.+rob[oó]tica[?!]$/i, :use_prefix => false, :method => :laws_of_robotics, :group => :conversation
  match /^(bot|zurg).+$/i, :use_prefix => false, :method => :message, :group => :conversation

  def help(m)
    m.reply "Comandos:"
    m.reply "!help => retorna essa mensagem"
    m.reply "o que <user> anda fazendo no twitter? => Retorna os últimos 5 tweets do usuário"
    m.reply "o que <user> anda fazendo no lastfm? => Retorna as últimas 5 músicas do usuário"
    m.reply "mais informações sobre <banda>! => Retorna informações sobre a banda"
    m.reply "onde está seu código? => Retorna o endereço do repositório"
    m.reply "Quais são as leis da robótica? => Retorna as leis da robótica"
    m.reply "Pergunte sobre o tempo: Como está o tempo em Teresina?"
    m.reply "Mensagens:"
    m.reply "!message:add <mensagem> => Adiciona uma mensagem"
    m.reply "!message:list => Lista todas as mensagens"
    m.reply "!message:show <id> => Mostra uma determinada mensagem"
    m.reply "!message:destroy <id> => Apaga uma determinada mensagem"
    m.reply "!message:update <id> <mensagem> => Atualiza uma determinada mensagem"
  end

  def message(m)
    m.reply random_message, true if Message.any?
  end

  def life(m)
    m.reply "A resposta para a pergunta fundamental sobra a vida, o Universo e tudo mais é 42.", true
  end

  def repository(m)
    m.reply "Meu código fonte está em https://github.com/caironoleto/zurg", true
  end

  def laws_of_robotics(m)
    m.reply "Um robô não pode ferir um ser humano ou, por omissão, permitir que um ser humano sofra algum mal", true
    m.reply "Um robô deve obedecer as ordens que lhe sejam dadas por seres humanos, exceto nos casos em que tais ordens entrem em conflito com a Primeira Lei", true
    m.reply "Um robô deve proteger sua própria existência desde que tal proteção não entre em conflito com a Primeira e/ou a Segunda Lei", true
  end

  private

  def random_message
    Message.where(:type_of_message => 'answer').order("RANDOM()").first.try(:content)
  end
end
