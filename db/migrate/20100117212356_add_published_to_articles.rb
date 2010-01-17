class AddPublishedToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :published, :datetime
  end

  def self.down
    remove_column :articles, :published
  end
end
