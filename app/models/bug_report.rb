class BugReport
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :title, :message
  validates_length_of :title, :maximum => 80
  validates_presence_of :title
  validates_presence_of :message

   def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
   end

   def persisted?
     false
   end
end