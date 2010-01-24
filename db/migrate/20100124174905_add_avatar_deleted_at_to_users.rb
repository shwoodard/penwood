class AddAvatarDeletedAtToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar_deleted_at, :datetime
  end

  def self.down
    remove_column :users, :avatar_deleted_at
  end
end
