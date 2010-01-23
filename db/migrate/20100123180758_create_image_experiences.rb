class CreateImageExperiences < ActiveRecord::Migration
  def self.up
    create_table :image_experiences do |t|
      t.string :type
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :image_experiences
  end
end
