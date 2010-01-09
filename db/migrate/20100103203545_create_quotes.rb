class CreateQuotes < ActiveRecord::Migration
  def self.up
    create_table :quotes do |t|
      t.text :body
      t.string :author
      t.integer :page_id
      t.string :text_identifier

      t.timestamps
    end
  end

  def self.down
    drop_table :quotes
  end
end
