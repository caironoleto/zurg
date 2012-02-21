# encoding: utf-8
class MessageManager < Base

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
      m.reply("#{m.user.nick}: #{Message.find(id).content}")
    rescue
      m.reply("#{m.user.nick}: Mensagem não encontrada.")
    end
  end

  def create(m, text)
    begin
      Message.create(:content => text, :type_of_message => 'answer')
      m.reply("#{m.user.nick}: Mensagem criada com sucesso!")
    rescue
      m.reply("#{m.user.nick}: Aconteceu algum erro na sua solicitação.")
    end
  end

  def update(m, id, text)
    begin
      Message.find(id).update_attributes(:content => text)
      m.reply("#{m.user.nick}: Mensagem atualizada com sucesso!")
    rescue
      m.reply("#{m.user.nick}: Aconteceu algum erro na sua solicitação.")
    end
  end

  def destroy(m, id)
    begin
      Message.find(id).destroy
      m.reply("#{m.user.nick}: Mensagem apagada com sucesso!")
    rescue
      m.reply("#{m.user.nick}: Aconteceu algum erro na sua solicitação.")
    end
  end
end
