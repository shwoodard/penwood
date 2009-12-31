class AddUserIdToConversationEntries < ActiveRecord::Migration
  def self.up
    add_column :conversation_entries, :user_id, :integer
  end

  def self.down
    remove_column :conversation_entries, :user_id
  end
end
