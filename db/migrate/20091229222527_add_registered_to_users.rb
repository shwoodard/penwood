class AddRegisteredToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :registered, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :users, :registered
  end
end
