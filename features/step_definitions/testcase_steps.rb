Given /^there exists an active Project$/ do
  Project.create!(:name => 'Testproject')
end

Given /^there exists a Testcase named "([^"]*)"$/ do |name|
  visit("/testcases/new")
  fill_in "Name", :with => name
  click_button "testcase_submit"
end
