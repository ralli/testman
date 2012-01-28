module ProjectsHelper
  def can_add_tracker_setting?(project)
    return project.tracker_setting.nil?
  end

  def can_edit_tracker_setting?(project)
    return (not project.tracker_setting.nil?)
  end
end
