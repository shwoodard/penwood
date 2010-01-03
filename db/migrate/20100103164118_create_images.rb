class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_updated_at
      t.integer :image_slide_show_id
      t.string :title
      t.integer :position
      t.integer :page_id
      t.string :text_identifier
      t.text :caption

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
