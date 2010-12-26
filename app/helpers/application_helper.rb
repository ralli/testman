module ApplicationHelper
  def can_show_testcases?
    (permitted_to? :read, :testcases) and (not current_project.nil?)
  end
end
