class AddTextIdToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :text_identifier, :string
  end

  def self.down
    remove_column :contents, :text_identifier
  end
end
