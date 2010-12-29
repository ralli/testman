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
  has_many :testsuite_entries, :dependent => :destroy, :order => :position
  has_many :testcases, :through => :testsuite_entries
  has_many :testsuiteruns, :dependent => :destroy
  
  attr_accessible :name, :description, :edited_by, :updated_by
  after_create :init_key

  def self.new_with_defaults(attributes = {})
    self.new({:version => 1}.merge(attributes))
  end

  def init_key
    update_attribute(:key, sprintf("TS%05d", id))
  end

  def add_testcase(testcase, user = nil)
    self.transaction do
      entry = TestsuiteEntry.new
      entry.testsuite = self
      entry.testcase = testcase
      entry.save
      self.update_attribute(:edited_by, user) if user
    end
  end

  def create_run(user)
    testsuiterun = Testsuiterun.create(:testsuite => self, :status => 'new', :result => 'unknown', :created_by => user, :edited_by => user)
    testsuite_entries.includes(:testcase).each do |entry|
      testsuiterun.testcaseruns << entry.testcase.create_run(user, testsuiterun, entry.position)
    end
    testsuiterun
  end
end
