class CreateTrackerSettings < ActiveRecord::Migration
  def change
    create_table :tracker_settings do |t|
      t.string  :type, :limit => 60, :nullable => false
      t.integer :project_id, :nullable => false
      t.string  :site, :limit => 255
      t.string  :user, :limit => 40
      t.string  :password, :limit => 40
    end
    add_index(:tracker_settings, :type)
    add_index(:tracker_settings, :project_id)
  end
end
