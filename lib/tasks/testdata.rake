require File.join(Rails.root, 'config', 'environment')
require File.join(Rails.root, 'spec', 'blueprints')
namespace :testman do

  task :testdata do
    Project.destroy_all
    User.destroy_all
    possible_tags = ['smalltalk', 'c++', 'ruby', 'python', 'haskell', 'fortran']
    project = Project.make!(:name => 'Test Project')
    user = User.make!(:login => 'admin', :password => 'admin', :password_confirmation => 'admin', :current_project => project)
    (1..10).each do |k|
      testsuite = Testsuite.make!(:project => project, :created_by => user, :edited_by => user, :name => "Testsuite ##{k}")
      (1..10).each do |i|
        testcase = Testcase.make!(:project => project, :created_by => user, :edited_by => user, :name => "Testcase ##{i} for testsuite ##{k}", :tag_list => [possible_tags.sample])
        (1..3).each do |j|
          Teststep.make!(:testcase => testcase, :step => "Test step No. #{j} for testcase #{i}", :expected_result => "Expected result ##{j} for testcase ##{i}")
        end
        testsuite.add_testcase(testcase, user)
      end
    end
  end

  task :deletedata do
    Project.destroy_all
    User.destroy_all
  end
end

