class AddQuoteEligibleToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :quote_eligible, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :pages, :quote_eligible
  end
end
