class AlterReadBy < ActiveRecord::Migration
  def self.up
    change_column :conversation_entries, :read, :text, :default => nil, :null => true
    rename_column :conversation_entries, :read, :read_by
  end

  def self.down
    rename_column :conversation_entries, :read_by, :read, :default => false, :null => false
    change_column :conversation_entries, :read, :boolean
  end
end
