class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name, :null => false, :limit => 80
      t.timestamps
    end

    add_index(:projects, :name)
  end

  def self.down
    drop_table :projects
  end
end
