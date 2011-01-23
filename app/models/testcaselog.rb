class Testcaselog < ActiveRecord::Base
  belongs_to :created_by, :class_name => 'User'
  belongs_to :testcaserun
end
