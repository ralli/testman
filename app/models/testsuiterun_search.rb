class TestsuiterunSearch
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :status, :result

  def initialize(attributes = {})
    @status = attributes[:status]
    @result = attributes[:result]
  end

  def persist
    @persisted = true
  end

  def persisted?
    @persisted || false
  end

  def to_query(project)
    query = project.testsuiteruns
    query = query.where('status=?',  @status) unless @status.blank?
    query = query.where('result=?', @result) unless @result.blank?
    query
  end
end

