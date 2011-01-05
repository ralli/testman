module ApplicationHelper
  include TagsHelper

  def can_show_testcases?
    (permitted_to? :read, :testcases) and (not current_project.nil?)
  end

  def can_show_testsuites?
    (permitted_to? :read, :testsuites) and (not current_project.nil?)
  end

  def can_show_testruns?
    (permitted_to? :read, :testsuiteruns) and (not current_project.nil?)
  end

  def render_textile(s)
    raw(RedCloth.new(s,  [:filter_html]).to_html)
  end
end
