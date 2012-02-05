class Testcase < ActiveRecord::Base
  acts_as_taggable_on :tags

  belongs_to :project
  belongs_to :created_by, :class_name => 'User'
  belongs_to :edited_by, :class_name => 'User'

  validates_presence_of :key, :on => :update
  validates_length_of :key, :maximum => 10
  validates_presence_of  :version
  validates_presence_of :name
  validates_length_of    :name, :maximum => 80
  validates_inclusion_of :enabled, :in => [true, false]
  validates_inclusion_of :test_area, :in =>  ["FUNCTIONAL", "NON-FUNCTIONAL", "STRUCTURAL", "REGRESSION", "RETEST"]
  validates_inclusion_of :test_variety, :in => ["POSITIVE", "NEGATIVE"]
  validates_inclusion_of :test_level, :in => ["COMPONENT_TEST", "SYSTEM_TEST", "INTEGRATION_TEST", "ACCEPTANCE_TEST"]
  validates_inclusion_of :execution_type, :in => ['MANUAL', 'AUTOMATIC']
  validates_inclusion_of :test_status, :in =>  ["DESIGN", "CONFIRMED", "LOCKED", "DISABLED"]
  validates_inclusion_of :test_priority, :in =>  ["LOW", "MEDIUM", "HIGH"]
  validates_inclusion_of :test_method, :in =>  ["BLACKBOX", "WHITEBOX"]
  has_many :teststeps, :order => 'position', :dependent => :destroy
  has_many :testsuite_entries, :dependent => :destroy
  has_many :testsuites, :through => :testsuite_entries
  has_many :testcaseruns, :dependent => :destroy
  has_many :testcase_attachments, :dependent => :destroy, :class_name => 'TestcaseAttachment', :order => 'position'
  has_many :bug_reports, :through => :testcaseruns

  before_validation :init_fields
  after_create :init_key

  attr_accessible :key, :version, :project, :name, :created_by, :edited_by, :description, :test_area, :test_variety, :test_level, :execution_type, :test_status, :test_priority, :test_method, :tag_list

  def self.new_with_defaults
    self.new(:key => 'NEW', :test_area => 'FUNCTIONAL', :test_variety => 'POSITIVE', :test_level => "INTEGRATION_TEST", :execution_type => 'MANUAL', :test_status => 'DESIGN', :test_priority => 'MEDIUM', :test_method => "BLACKBOX")
  end

  def init_key
    update_attribute(:key, sprintf('TC%05d', id)) if key == 'NEW' or key.blank?
  end

  def init_fields
    self.version = 1 if version.nil? and new_record?
  end

  def self.keys_for(method)
    list = self.send(method.to_sym)
    list.collect {|item| item[1] }
  end

  def create_run(user, testsuiterun, position)
    testcaserun = Testcaserun.create!(:testcase => self, :testsuiterun => testsuiterun, :created_by => user, :edited_by =>  user, :position => position, :status => 'new', :result => 'unknown')
    teststeps.each do |teststep|
      testcaserun.teststepruns << teststep.create_run(user, testcaserun)
    end
    testcaserun
  end

  def create_version(user = nil)
    user = user || edited_by
    copy = Testcase.new(attributes.merge(:project => project, :created_by => created_by, :edited_by => edited_by, :version => version + 1))
    copy.tag_list = tag_list
    copy.save!
    teststeps.each do |step|
      copy.teststeps.create(step.attributes)
    end
    testcase_attachments.each do |attachment|
      attachment_copy = copy.testcase_attachments.build(attachment.attributes)
      attachment_copy.attachment = attachment.attachment
      attachment.save
    end
    copy
  end

  def self.search(pattern)
    pattern = "%#{pattern.downcase.strip}%"
    search = Testcase.select('distinct testcases.id, testcases.key, testcases.version, testcases.name, testcases.execution_type, testcases.test_status, testcases.test_priority')
    search = search.joins('left outer join teststeps on teststeps.testcase_id=testcases.id')
    search = search.where("lcase(testcases.name) like ? or lcase(testcases.description) like ? or lcase(teststeps.step) like ? or lcase(teststeps.expected_result) like ?", pattern, pattern, pattern, pattern)
    search
  end
end

