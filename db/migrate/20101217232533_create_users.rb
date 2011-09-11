class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login, :null => false, :limit => 20
      t.string    :first_name, :limit => 80
      t.string    :last_name, :limit => 80
      t.string    :email, :null => false, :limit => 80
      t.string    :password_digest

      t.integer   :current_project_id
      t.timestamps
    end

    add_index :users, :login, :unique => true
    add_index :users, :last_name
    add_index :users, :current_project_id
  end

  def self.down
    drop_table :users
  end
end

