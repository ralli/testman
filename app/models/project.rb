class Project < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :maximum => 80
  
  attr_accessible :name

  def to_label
    name
  end
end
