class AddShowWelcomeDialogToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :show_welcome_dialog, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :users, :show_welcome_dialog
  end
end
