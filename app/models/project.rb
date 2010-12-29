class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  has_many :testcases, :dependent => :destroy
  has_many :testsuites, :dependent => :destroy
  has_many :current_users, :foreign_key => :current_project_id
  has_many :testsuiteruns, :through => :testsuites
  
  attr_accessible :name

  def to_label
    name
  end
end
