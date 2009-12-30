class ChangeSuperUserInUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :super_user, :boolean, :null => false, :default => false
    change_column :users, :admin, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :users, :super_user, :boolean, :null => true, :default => nil
    change_column :users, :admin, :boolean, :null => true, :default => nil
  end
end
