class AddTrackerProjectIdToTrackerSettings < ActiveRecord::Migration
  def change
    add_column :tracker_settings, :tracker_project_id, :integer, :nulls => false
    add_column :tracker_settings, :tracker_project_name, :string, :limit => 255
    add_column :tracker_settings, :tracker_project_key, :string, :limit => 60
  end
end
