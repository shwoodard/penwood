class CreateImageSlideShows < ActiveRecord::Migration
  def self.up
    create_table :image_slide_shows do |t|
      t.string :title
      t.string :text_identifier
      t.integer :page_id

      t.timestamps
    end
  end

  def self.down
    drop_table :image_slide_shows
  end
end
