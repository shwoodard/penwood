class ChangeConversationsTitleToSubject < ActiveRecord::Migration
  def self.up
    remove_column :conversations, :title
    add_column :conversations, :subject, :string
  end

  def self.down
    add_column :conversations, :title, :string
    remove_column :conversations, :subject
  end
end
