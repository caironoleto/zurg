class AddingTypeOfMessageToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :type_of_message, :string, :default => 'answer'
  end
end
