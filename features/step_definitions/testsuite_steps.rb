When /^I click the move up link for #{capture_model}$/ do |entry_id|
  entry = model(entry_id)
  visit move_testcase_up_url(entry.testsuite, entry)
end

When /^I click the move down link for #{capture_model}$/ do |entry_id|
  entry = model(entry_id)
  visit move_testcase_down_url(entry.testsuite, entry)
end

Then /^the position of #{capture_model} should be "([^"]*)"$/ do |entry_id, position|
  entry = model(entry_id)
  entry.position.to_s.should== position.to_s
end
