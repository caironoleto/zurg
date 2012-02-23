# encoding: utf-8
class MessageManager
  include Cinch::Plugin
  match /message:list/i, :method => :index
  match /message:add (.+)/i, :method => :create
  match /message:show (\d)/i, :method => :show
  match /message:destroy (\d)/i, :method => :destroy
  match /message:update (\d) (.+)/i, :method => :update

  def index(m)
    Message.all.each{|c| m.user.send("[#{c.id}] #{c.content}") }
  end

  def show(m, id)
    begin
      m.reply Message.find(id).content, true
    rescue
      m.reply "Mensagem não encontrada.", true
    end
  end

  def create(m, text)
    begin
      Message.create(:content => text, :type_of_message => 'answer')
      m.reply "Mensagem criada com sucesso!", true
    rescue
      m.reply "Aconteceu algum erro na sua solicitação.", true
    end
  end

  def update(m, id, text)
    begin
      Message.find(id).update_attributes(:content => text)
      m.reply "Mensagem atualizada com sucesso!", true
    rescue
      m.reply "Aconteceu algum erro na sua solicitação.", true
    end
  end

  def destroy(m, id)
    begin
      Message.find(id).destroy
      m.reply "Mensagem apagada com sucesso!", true
    rescue
      m.reply "Aconteceu algum erro na sua solicitação.", true
    end
  end
end
