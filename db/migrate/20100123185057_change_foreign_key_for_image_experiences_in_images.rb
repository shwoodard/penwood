class ChangeForeignKeyForImageExperiencesInImages < ActiveRecord::Migration
  def self.up
    rename_column :images, :image_slide_show_id, :image_experience_id
  end

  def self.down
    rename_column :images, :image_experience_id, :image_slide_show_id
  end
end
