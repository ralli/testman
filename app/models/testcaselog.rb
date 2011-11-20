class Testcaselog < ActiveRecord::Base
  belongs_to :created_by, :class_name => 'User'
  belongs_to :testcaserun
  validates_presence_of :testcaserun
  validates_presence_of :created_by

  def self.all_since(date)
    where('created_at >= ?', date).order('created_at')
  end

  def self.for_project(project_id)
    q = scoped
    q = q.joins(:testcaserun => :testcase)
    q = q.where("testcases.project_id = ?", project_id)
    q
  end
end
