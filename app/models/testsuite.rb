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

  validates_presence_of :project
  validates_presence_of :created_by
  validates_presence_of :edited_by
  
  has_many :testsuite_entries, :dependent => :destroy, :order => :position, :class_name => 'TestsuiteEntry'
  has_many :testcases, :through => :testsuite_entries
  has_many :testsuiteruns, :dependent => :destroy
  
  after_create :init_key

  def self.new_with_defaults(attributes = {})
    self.new({:version => 1}.merge(attributes))
  end

  def init_key
    if key.blank? or key == 'NEW' then
      update_attribute(:key, sprintf("TS%05d", id))
    end
  end

  def add_testcase(testcase, user = nil)
    entry = TestsuiteEntry.new
    self.transaction do      
      entry.testsuite = self
      entry.testcase = testcase
      entry.save
      self.update_attribute(:edited_by, user) if user
    end
    entry
  end

  def create_run(user)
    testsuiterun = Testsuiterun.create!(:testsuite => self, :status => 'new', :result => 'unknown', :created_by => user, :edited_by => user)

    # normally i would have been using "testsuite_entries.includes(:testcase).each"
    # but the rspec failed using an invalid column name for the testcase_id in the sql-statement...
    TestsuiteEntry.includes(:testcase).where(:testsuite_id => self.id).order("position").each do | entry |
      testsuiterun.testcaseruns << entry.testcase.create_run(user, testsuiterun, entry.position)
    end
    testsuiterun
  end

  def create_version(user)    
    copy = Testsuite.create!(self.attributes.merge({:project => project, :created_by => created_by, :edited_by => user, :version => version + 1}))
    TestsuiteEntry.includes(:testcase).where(:testsuite_id => self.id).order('position').each do |entry|
      new_entry = copy.testsuite_entries.build(:testcase => entry.testcase)
      new_entry.save!
    end
    copy
  end

  def self.search(pattern)
    if /TS\d{5}/i.match(pattern.strip) then
      return Testsuite.where('testsuites.key = ?', pattern)
    end
    pattern = "%#{pattern.to_s.downcase.strip}%"
    testsuites = Testsuite.scoped
    testsuites = Testsuite.where("lcase(testsuites.name) like ? or lcase(testsuites.description) like ?", pattern, pattern)
    return testsuites
  end
end
