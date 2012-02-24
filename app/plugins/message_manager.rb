# encoding: utf-8
class MessageManager
  attr_accessor :mutex
  include Cinch::Plugin
  match /message:list/i, :method => :index
  match /message:add (.+)/i, :method => :create
  match /message:show (\d+)/i, :method => :show
  match /message:destroy (\d+)/i, :method => :destroy
  match /message:update (\d+) (.+)/i, :method => :update

  def initialize(*args)
    super
    self.mutex = Mutex.new
  end

  def index(m)
    begin
      Message.all.each{|c| m.user.send("[#{c.id}] #{c.content}") }
    rescue Exception => e
      m.reply "Aconteceu algum erro na sua solicitação. #{e.inspect}", true
    end
  end

  def show(m, id)
    begin
      m.reply Message.find(id).content, true
    rescue Exception => e
      m.reply "Aconteceu algum erro na sua solicitação. #{e.inspect}", true
    end
  end

  def create(m, text)
    begin
      Message.create(:content => text, :type_of_message => 'answer')
      m.reply "Mensagem criada com sucesso!", true
    rescue Exception => e
      m.reply "Aconteceu algum erro na sua solicitação. #{e.inspect}", true
    end
  end

  def update(m, id, text)
    begin
      mutex.synchronize do
        message = Message.find(id)
        if message.update_attributes(:content => text)
          m.reply "Mensagem atualizada com sucesso!", true
        else
          m.reply "Aconteceu algum erro na sua solicitação. #{message.errors.inspect}", true
        end
      end
    rescue Exception => e
      m.reply "Aconteceu algum erro na sua solicitação. #{e.inspect}", true
    end
  end

  def destroy(m, id)
    begin
      mutex.synchronize do
        message = Message.find(id)
        if message.destroy
          m.reply "Mensagem apagada com sucesso!", true
        else
          m.reply "Aconteceu algum erro na sua solicitação. #{message.errors.inspect}", true
        end
      end
    rescue Exception => e
      m.reply "Aconteceu algum erro na sua solicitação. #{e.inspect}", true
    end
  end
end
