require 'authlogic/test_case'

Given /^there is no user logged in$/ do

end

Given /^(?:|I )enter the following values$/ do |table|
  with_scope(nil) do
    table.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end


Given /^I am logged in with login "([^"]*)" and password "([^"]*)"$/ do |login, password|
  user_session = UserSession.new(:login => login, :password => password)
  user_session.save!
end

Given /^I am logged in as user "([^"]*)"$/ do |login|
  user = User.find_by_login(login)
  user.destroy unless user.nil?
  Given "a user exists with login: \"#{login}\", password: \"test123\", password_confirmation: \"test123\""
  visit login_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => 'test123'
  click_button "user_session_submit"
end

Given /^I am logged in as user "([^"]*)" for #{capture_model}$/ do |login, name|
  user = User.find_by_login(login)
  user.destroy unless user.nil?
  Given "a user exists with login: \"#{login}\", password: \"test123\", password_confirmation: \"test123\", current_project: #{name}"
  visit login_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => 'test123'
  click_button "user_session_submit"
end

