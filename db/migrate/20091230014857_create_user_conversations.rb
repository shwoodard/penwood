class CreateUserConversations < ActiveRecord::Migration
  def self.up
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :creator, :null => :false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_conversations
  end
end
