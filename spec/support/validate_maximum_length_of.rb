class ValidateMaximumLengthOfToBe #:nodoc:
  def initialize(attribute, maxlength)
    @attribute = attribute
    @maxlength = maxlength
    @owner = nil
  end

  def matches?(obj)
    @owner = obj
    setter_name = "#{@attribute}=".to_sym
    val = "a" * @maxlength
    obj.send(setter_name, val)
    obj.valid?
    name_errors = obj.errors.messages[@attribute.to_sym]
    return false unless name_errors.nil? || name_errors.empty?
    val = "a" * (@maxlength+1)
    obj.send(setter_name, val)
    obj.valid?
    name_errors = obj.errors.messages[@attribute.to_sym]
    return !name_errors.nil? && !name_errors.empty?
  end

  def failure_message_for_should
    "expected #{@owner.class.name} to validate the maximum length of #{@attribute.to_sym} to be #{@maxlength}"
  end

  def failure_message_for_should_not
    "expected #{@owner.class.name} to validate the maximum length of #{@attribute.to_sym} *NOT* to be #{@maxlength}"
  end

  def description
    "validate the maximum length of #{@attribute.to_sym} to be #{@maxlength}"
  end
end

class ValidateMaxlengthWrapper #:nodoc:
  def initialize(attribute_name)
    @attribute_name = attribute_name
  end

  def to_be(maxlength)
    ValidateMaximumLengthOfToBe.new(@attribute_name, maxlength)
  end
end

def validate_maximum_length_of(attribute_name)
  ValidateMaxlengthWrapper.new(attribute_name)
end

