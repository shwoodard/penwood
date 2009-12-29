class AlterPublishedInTestimonials < ActiveRecord::Migration
  def self.up
    change_column :testimonials, :published, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :testimonials, :published, :boolean, :null => true, :default => nil
  end
end
