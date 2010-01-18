class AddScribdFieldsToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :ipaper_id, :integer
    add_column :articles, :ipaper_access_key, :string
  end

  def self.down
    remove_column :articles, :ipaper_id
    remove_column :articles, :ipaper_access_key
  end
end
