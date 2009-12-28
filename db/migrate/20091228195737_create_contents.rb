class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.integer :page_id
      t.text :body
      t.string :title
      t.integer :charlimit

      t.timestamps
    end
  end

  def self.down
    drop_table :contents
  end
end
