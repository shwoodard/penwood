class AddPageIdToImageExperiences < ActiveRecord::Migration
  def self.up
    add_column :image_experiences, :page_id, :integer
  end

  def self.down
    remove_column :image_experiences, :page_id
  end
end
