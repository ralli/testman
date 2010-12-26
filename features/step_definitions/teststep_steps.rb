When /^I click "move_up" for (.*)$/ do |obj|
  teststep = model(obj)
  visit move_up_path(teststep.testcase, teststep)
end

When /^I click "move_down" for (.*)$/ do |obj|
  teststep = model(obj)
  visit move_down_path(teststep.testcase, teststep)
end

Then /^#{capture_model} has position "([^"]*)"/ do |model_name, position|
  teststep = model(model_name)
  teststep.position.to_s.should== position.to_s
end
