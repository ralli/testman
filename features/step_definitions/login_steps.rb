require 'authlogic/test_case'

Given /^there exists a User with login "([^"]*)" and password "([^"]*)" and email "([^"]*)" and first name "([^"]*)" and last name "([^"]*)"$/ do |login, password, email, first_name, last_name|
  User.delete(:all)
  User.create(:login => login, :password => password, :password_confirmation => password, :email => email, :first_name => first_name, :last_name => last_name)
end

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

Given /^I am logged in as User "([^"]*)"$/ do |login|  
  user = User.find_by_login(login)
  if user.nil?
    user = User.create(:login => login, :password => 'test123', :password_confirmation => 'test123', :email => 'noreply@test.com')
  end
  visit login_path
  fill_in "Login", :with => login
  fill_in "Password", :with => 'test123'
  click_button "Login"
end
