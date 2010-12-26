class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login, :null => false, :limit => 20
      t.string    :first_name, :limit => 80
      t.string    :last_name, :limit => 80
      t.string    :email, :null => false, :limit => 80
      t.string    :crypted_password, :null => false
      t.string    :password_salt, :null => false
      t.string    :persistence_token, :null => false
      t.string    :single_access_token, :null => false

      t.integer   :login_count, :null => false, :default => 0
      t.integer   :failed_login_count, :null => false, :default => 0
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip

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
