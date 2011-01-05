class CacheTagTestcases < ActiveRecord::Migration
  def self.up
    add_column :testcases, :cached_tag_list, :string
  end

  def self.down
    remove_column :testcases, :cached_tag_list
  end
end
