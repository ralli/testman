class AddLocaleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :locale, :string, :limit => 10
  end

  def self.down
    drop_column :users, :locale
  end
end

