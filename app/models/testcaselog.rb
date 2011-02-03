class Testcaselog < ActiveRecord::Base
  belongs_to :created_by, :class_name => 'User'
  belongs_to :testcaserun

  def self.all_since(date)
    where('created_at >= ?', date).order('created_at')
  end
end

