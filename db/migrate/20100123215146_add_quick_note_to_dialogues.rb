class AddQuickNoteToDialogues < ActiveRecord::Migration
  def self.up
    add_column :conversations, :quick_note, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :conversations, :quick_note
  end
end
