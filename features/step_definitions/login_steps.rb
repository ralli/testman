def create_user(fields)
  create_model('user', fields)
end

Given /^there is no user logged in$/ do

end

Given /^(?:|I )enter the following values$/ do |table|
  with_scope(nil) do
    table.rows_hash.each do |name, value|
      fill_in name, :with => value
    end
  end
end

Given /^I am logged in as user "([^"]*)"$/ do |login|
  user = User.find_by_login(login)
  user.destroy unless user.nil?
  create_user(:login => login, :password => 'test123', :password_confirmation => 'test123')
  visit login_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => 'test123'
  click_button "commit"
end

Given /^I am logged in as user "([^"]*)" for #{capture_model}$/ do |login, name|
  user = User.find_by_login(login)
  user.destroy unless user.nil?
  project = model(name)
  create_user(:login => login, :password => 'test123', :password_confirmation => 'test123', :current_project => project)
  visit login_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => 'test123'
  click_button "commit"
end

Given /^I am logged in as administrator "([^"]*)"$/ do |login|
  user = User.find_by_login(login)
  user.destroy unless user.nil?
  create_user(:login => login, :password => 'test123', :password_confirmation => 'test123')
  visit login_path
  fill_in "user_session_login", :with => login
  fill_in "user_session_password", :with => 'test123'
  click_button "commit"
end

