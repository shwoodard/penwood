class CreatePictureWindows < ActiveRecord::Migration
  def self.up
    create_table :picture_windows do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :picture_windows
  end
end
