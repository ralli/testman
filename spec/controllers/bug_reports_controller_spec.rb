require 'spec_helper'

describe BugReportsController do
  let(:project) { mock_model(Project, :tracker_setting => redmine_setting) }
  let(:testsuite) { mock_model(Testsuite) }
  let(:testcase) { mock_model(Testcase) }
  let(:teststep) { mock_model(Teststep, :position => 23) }
  let(:testsuiterun) { mock_model(Testsuiterun, :testsuite => testsuite, :project => project).as_null_object }
  let(:testcaserun) {mock_model(Testcaserun, :testcase => testcase, :position => 73)}
  let(:teststeprun) { mock_model(Teststeprun, :teststep => teststep) }
  let(:redmine_setting) { mock_model(RedmineSetting) }
  let(:bug_report) { mock_model(BugReport).as_null_object }
  let(:issue) { mock_model(Redmine::Issue) }

  describe "GET new" do
    before do
      Testsuiterun.stub(:find).with(testsuiterun.to_param) { testsuiterun }
    end

    it "should assign the testsuiterun variable" do
      get('new', :testsuiterun_id => testsuiterun.to_param)
      assigns(:testsuiterun).should == testsuiterun
    end

    it "should assign the bug_report variable" do
      get('new', :testsuiterun_id => testsuiterun.to_param)
      assigns(:bug_report).should_not be_nil
    end

    context "when the teststeprun_id param is passed" do
      before do
        Testcaserun.stub(:find).with(testcaserun.to_param) { testcaserun }
        Teststeprun.stub(:find).with(teststeprun.to_param) { teststeprun }
      end
      it "should assign the testcaserun_id to the bug_report" do
        get('new', :testsuiterun_id => testsuiterun.to_param, :teststeprun_id => teststeprun.to_param, :testcaserun_id => testcaserun.to_param)
        assigns(:bug_report).testcaserun_id.to_param.should == testcaserun.to_param
      end

      it "should assign the teststeprun_id to the bug_report" do
        get('new', :testsuiterun_id => testsuiterun.to_param, :teststeprun_id => teststeprun.to_param, :testcaserun_id => testcaserun.to_param)
        assigns(:bug_report).teststeprun_id.to_param.should == teststeprun.to_param
      end

      it "should include the testcases position within the bug_reports message" do
        get('new', :testsuiterun_id => testsuiterun.to_param, :teststeprun_id => teststeprun.to_param, :testcaserun_id => testcaserun.to_param)
        assigns(:bug_report).message.should match(Regexp.new(testcaserun.position.to_s))
      end

      it "should include the test steps position within the bug_reports message" do
        get('new', :testsuiterun_id => testsuiterun.to_param, :teststeprun_id => teststeprun.to_param, :testcaserun_id => testcaserun.to_param)
        assigns(:bug_report).message.should match(Regexp.new(teststep.position.to_s))
      end

      it "should include the testsuites id in the message" do
        get('new', :testsuiterun_id => testsuiterun.to_param, :teststeprun_id => teststeprun.to_param, :testcaserun_id => testcaserun.to_param)
        assigns(:bug_report).message.should match(Regexp.new(testsuiterun.testsuite.to_param))
      end
    end

    context "when no teststeprun_id is passed" do
      it "should include the testsuites id in the message" do
        get('new', :testsuiterun_id => testsuiterun.to_param)
        assigns(:bug_report).message.should match(Regexp.new(testsuiterun.testsuite.to_param))
      end

      it "should not include the testcases position within the bug_reports message" do
        get('new', :testsuiterun_id => testsuiterun.to_param)
        assigns(:bug_report).message.should_not match(Regexp.new(testcaserun.position.to_s))
      end

      it "should not include the test steps position within the bug_reports message" do
        get('new', :testsuiterun_id => testsuiterun.to_param,)
        assigns(:bug_report).message.should_not match(Regexp.new(teststep.position.to_s))
      end

      it "should include the testsuites id in the message" do
        get('new', :testsuiterun_id => testsuiterun.to_param)
        assigns(:bug_report).message.should match(Regexp.new(testsuiterun.testsuite.to_param))
      end
    end
  end

  describe "POST create" do
    before do
      Testsuiterun.stub(:find).with(testsuiterun.to_param) { testsuiterun }
      BugReport.stub(:new) { bug_report }
    end

    it "should assign the testsuiterun variable" do
      get('new', :testsuiterun_id => testsuiterun.to_param)
      assigns(:testsuiterun).should == testsuiterun
    end

    context "when validation fails" do
      before do
        bug_report.stub(:valid?) { false }
      end

      it "should render the new template" do
        post('create', :testsuiterun_id => testsuiterun.to_param)
        response.should render_template('new')
      end
    end

    context "when validation succeeds" do
      before do
        bug_report.stub(:valid?) { true }
      end


      context "when no bug tracker configured" do
        before do
          project.stub(:tracker_setting) { nil }
        end
        it "should redirect to the test suite runs show page" do
          post('create', :testsuiterun_id => testsuiterun.to_param)
          response.should redirect_to(testsuiterun)
        end

        it "should show a success message" do
          post('create', :testsuiterun_id => testsuiterun.to_param)
          flash[:notice].should_not be_nil
        end
      end

      context "when redmine configured as bug tracker" do
        before do
          project.stub(:tracker_setting) { redmine_setting }
          Redmine::Issue.stub(:create) { issue }
        end

        it "should redirect to the test suite runs show page" do
          post('create', :testsuiterun_id => testsuiterun.to_param)
          response.should redirect_to(testsuiterun)
        end
      end

      context "with a teststep_id given" do
        before do
          project.stub(:tracker_setting) { nil }
          bug_report.stub(:teststeprun_id => teststeprun.to_param)
        end
        it "should redirect to the test suite runs show page" do
            post('create', :testsuiterun_id => testsuiterun.to_param, :bug_report => { :teststeprun_id => teststeprun.to_param })
            response.should redirect_to(testsuiterun)
        end
      end
    end
  end

  describe "GET show" do
    before do
      Testsuiterun.stub(:find).with(testsuiterun.to_param) { testsuiterun }
      BugReport.stub(:find).with(bug_report.to_param) { bug_report }
    end

    it "should assign the testsuiterun variable" do
      get 'show', :id => bug_report.to_param, :testsuiterun_id => testsuiterun.to_param
      assigns(:testsuiterun).should == testsuiterun
    end

    it "should assign the bug_report variable" do
      get 'show', :id => bug_report.to_param, :testsuiterun_id => testsuiterun.to_param
      assigns(:bug_report).should == bug_report
    end

    it "should render the show template" do
      get 'show', :id => bug_report.to_param, :testsuiterun_id => testsuiterun.to_param
      response.should render_template('show')
    end
  end
end
