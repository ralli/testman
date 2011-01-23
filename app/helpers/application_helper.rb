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

  def cancel_link(*args)
    model = args[0]
    options = args[1] || {}
    html_options = args[2]
    url = model.new_record? ? polymorphic_path(model.class) : polymorphic_path(model)    
    label = options[:label] || "Cancel"
    link_to(label, url, options, html_options)
  end
end
