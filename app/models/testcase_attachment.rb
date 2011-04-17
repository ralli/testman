class TestcaseAttachment < ActiveRecord::Base
  belongs_to :testcase
  acts_as_list :scope => :testcase
  has_attached_file :attachment

  validates_attachment_presence :attachment, :message => I18n::t('testcase_attachment.attachment_required')
  validates_presence_of :attachment
end

