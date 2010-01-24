class AddReadToConversationEntries < ActiveRecord::Migration
  def self.up
    add_column :conversation_entries, :read, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :conversation_entries
  end
end
