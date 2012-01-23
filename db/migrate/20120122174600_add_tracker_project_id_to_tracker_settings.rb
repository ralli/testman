class AddTrackerProjectIdToTrackerSettings < ActiveRecord::Migration
  def change
    add_column :tracker_settings, :tracker_project_id, :integer, :nulls => false
  end
end
