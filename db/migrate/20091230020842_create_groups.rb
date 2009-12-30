class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.integer :group_type_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
