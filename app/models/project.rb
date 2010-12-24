class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  has_many :testcases, :dependent => :destroy
  
  attr_accessible :name

  def to_label
    name
  end
end
