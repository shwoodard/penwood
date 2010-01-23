class DropImageExperienceSubclassTablesForSti < ActiveRecord::Migration
  def self.up
    # Bad but needed so that we delete paperclip files too
    Image.destroy_all

    # let's just be sure
    delete "truncate images"
    delete "truncate image_slide_shows"
    delete "truncate picture_windows"

    drop_table :image_slide_shows
    drop_table :picture_windows
  end

  def self.down
    create_table :image_slide_shows
    create_table :picture_windows
  end
end
