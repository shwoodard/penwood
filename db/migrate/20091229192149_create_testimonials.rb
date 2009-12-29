class CreateTestimonials < ActiveRecord::Migration
  def self.up
    create_table :testimonials do |t|
      t.text :body
      t.string :name
      t.string :location
      t.integer :user_id
      t.boolean :published

      t.timestamps
    end
  end

  def self.down
    drop_table :testimonials
  end
end
