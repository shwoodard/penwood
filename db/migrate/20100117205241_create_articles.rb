class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :attachment_file_name
      t.integer :attachment_file_size
      t.string :attachment_content_type
      t.datetime :attachment_updated_at
      t.text :body
      t.string :title
      t.string :author
      t.string :type
      t.text :tags

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
