class Testcase < ActiveRecord::Base

  belongs_to :project
  belongs_to :created_by, :class_name => 'User'
  belongs_to :edited_by, :class_name => 'User'
  
  validates_presence_of :key
  validates_length_of :key, :maximum => 10
  validates_presence_of  :version
  validates_length_of    :name, :maximum => 80
  validates_inclusion_of :enabled, :in => [true, false]
  validates_inclusion_of :test_area, :in =>  ["FUNCTIONAL", "NON-FUNCTIONAL", "STRUCTURAL", "REGRESSION", "RETEST"]
  validates_inclusion_of :test_variety, :in => ["POSITIVE", "NEGATIVE"]
  validates_inclusion_of :test_level, :in => ["COMPONENT_TEST", "SYSTEM_TEST", "INTEGRATION_TEST", "ACCEPTANCE_TEST"]
  validates_inclusion_of :execution_type, :in => ['MANUAL', 'AUTOMATIC']
  validates_inclusion_of :test_status, :in =>  ["DESIGN", "CONFIRMED", "LOCKED", "DISABLED"]
  validates_inclusion_of :test_priority, :in =>  ["LOW", "MEDIUM", "HIGH"]
  validates_inclusion_of :test_method, :in =>  ["BLACKBOX", "WHITEBOX"]
  before_validation :init_fields
  after_create :init_key
  
  attr_accessible :version, :project_id, :name, :created_by_id, :edited_by_id, :description,    :test_area, :test_variety, :test_level, :execution_type, :test_status, :test_priority, :test_method

  def self.new_with_defaults
    self.new(:key => 'NEW', :test_area => 'FUNCTIONAL', :test_variety => 'POSITIVE', :test_level => "INTEGRATION_TEST", :execution_type => 'MANUAL', :test_status => 'DESIGN', :test_priority => 'MEDIUM', :test_method => "BLACKBOX")
  end

  def init_key
    update_attribute(:key, sprintf('TC%05d', id)) if key == 'NEW'
  end
  
  def init_fields    
    self.version = 1 if version.nil? and new_record?
  end

  def value_for(attribute)
    key = self.send(attribute.to_sym)
    method = attribute.to_s.pluralize.to_sym
    list = self.class.send(method)
    p = list.detect { |e| e[1] == key }
    p.nil? ? '<Undefined>' :  p[0]
  end
 
  def self.keys_for(method)
    list = self.send(method.to_sym)
    list.collect {|item| item[1] }    
  end
  
  def self.test_areas
    [['Functional', 'FUNCTIONAL'],
      ['Non-Functional', 'NON-FUNCTIONAL'],
      ['Structural', 'STRUCTURAL'],
      ['Regression', 'REGRESSION'],
      ['Re-Test', 'RETEST']]
  end

  def self.test_varieties
    [['Positive', 'POSITIVE'],
      ['Negative', 'NEGATIVE']]
  end

  def self.test_priorities
    [['Low', 'LOW'],
      ['Medium', 'MEDIUM'],
      ['High', 'HIGH']]
  end

  def self.test_methods
    [['Black box', 'BLACKBOX'],
      ['White box', 'WHITEBOX'],]
  end

  def self.test_statuses
    [['Design', 'DESIGN'],
      ['Confirmed', 'CONFIRMED'],
      ['Locked', 'LOCKED'],
      ['Disabled', 'DISABLED'],]
  end

  def self.test_levels
    [['Component Test', 'COMPONENT_TEST'],
      ['System Test', 'SYSTEM_TEST'],
      ['Integration Test', 'INTEGRATION_TEST'],
      ['Acceptance Test', 'ACCEPTANCE_TEST'],]
  end

  def self.execution_types
    [['Manual', 'MANUAL'],
      ['Automatic', 'AUTOMATIC']]    
  end
end
