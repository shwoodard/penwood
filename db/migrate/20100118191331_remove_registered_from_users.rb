class RemoveRegisteredFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :registered
  end

  def self.down
    add_column :users, :registered, :boolean, :null => false, :default => true
  end
end
