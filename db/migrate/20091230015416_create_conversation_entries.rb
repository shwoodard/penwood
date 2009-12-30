class CreateConversationEntries < ActiveRecord::Migration
  def self.up
    create_table :conversation_entries do |t|
      t.text :body
      t.integer :conversation_id

      t.timestamps
    end
  end

  def self.down
    drop_table :conversation_entries
  end
end
