RSpec::Matchers.define :validate_presence_of do | attribute |
  match do |obj|
    setter_name = "#{attribute}=".to_sym
    obj.send(setter_name, nil)
    obj.valid?
    my_errors = obj.errors.messages[attribute.to_sym]
    !my_errors.nil? && my_errors.include?("can't be blank")
  end

  failure_message_for_should do |obj|
    "expected #{obj.class.name} to validate the presence of #{attribute.to_sym}"
  end

  failure_message_for_should_not do |obj|
    "expected #{obj.class.name} to *NOT* validate the presence of #{attribute.to_sym}"
  end

  description do
    "validate the presence of #{attribute.to_sym}"
  end
end

