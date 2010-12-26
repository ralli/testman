class Testsuite < ActiveRecord::Base
  validates_presence_of :key, :on => :update
  validates_length_of :key, :maximum => 10
  validates_presence_of :version
  validates_presence_of :enabled
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  belongs_to :created_by, :class_name => 'User'
  belongs_to :edited_by, :class_name => 'User'
  belongs_to :project
  
  attr_accessible :name, :description
end
