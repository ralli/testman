class Testcaserun < ActiveRecord::Base
  belongs_to :testsuiterun
  
  belongs_to :testcase
  validates_presence_of :testcase

  validates_presence_of :status
  validates_length_of :status, :maximum => 20
  validates_inclusion_of :status, :in => ['new', 'running', 'ended']

  validates_presence_of :result
  validates_length_of :result, :maximum => 20
  validates_inclusion_of :result, :in => ['unknown', 'ok', 'failed', 'error', 'skipped']

  has_many :teststepruns, :dependent => :destroy, :order => 'position'
  
  belongs_to :created_by, :class_name => 'User'
  validates_presence_of :created_by
  belongs_to :edited_by, :class_name => 'User'
  validates_presence_of :edited_by

  after_create :create_log

  def nextstep
    teststepruns.where(["status <> ?", 'ended']).first
  end

  def next?
    not nextstep.nil?
  end

  def step(user, result)
    s = nextstep
    return nil if s.nil?
    s.step(user, result)
    if nextstep.nil? then
      update_attributes!(:edited_by => user, :status => 'ended', :result => result)
      Testcaselog.create!(:created_by => user, :testcaserun => self, :status => 'ended', :result => result)
    end
    s
  end

  def set_all(user, result)
    teststepruns.each do |run|
      run.status = 'ended'
      run.result = result
      run.save!
    end
    self.status = 'ended'
    self.result = result
    save!
    create_log
  end
  
  def testcasecount
    testsuiterun.try(:testcaseruns).try(:count) || 0
  end

  private
  def create_log
    Testcaselog.create!(:created_by => created_by, :testcaserun => self, :status => status, :result => result)
  end
end
