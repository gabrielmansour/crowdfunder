require 'spec_helper'

describe "My Projects flow" do
  describe "My Projects list" do
    before do
      me = create_user_and_login
      other_user = create(:user)
      3.times { create(:project, user: me) }
      2.times { create(:project, user: other_user, title: "Other Dude's Project") }

      visit my_projects_path
    end

    it "should list only my projects" do
      all("ul#projects > li").should have(3).items
    end

    it "should not list others' projects" do
      page.should_not have_content "Other Dude's Project"
    end
  end

  describe "Create New Project" do
    before do
      create_user_and_login

      visit my_projects_path
      click_link "Create New Project"
    end

    it "should display the new project form" do
      page.should have_css("form#new_project")
      find("h1").text.should == "New Project"
    end

    context "fill in form correctly" do
      before do
        project = build(:project)
        fill_in :project_title, with: project.title
        fill_in :project_teaser, with: project.teaser
        fill_in :project_description, with: project.description
        fill_in :project_goal, with: project.goal
        click_button "Publish Project"
      end

      it "should display a notification message" do
        find(".alert").text.should == "Your project was created!"
      end

      it "should add the new project to the My Projects page" do
        visit my_projects_path
        find("ul#projects").should have_content "5D Glasses"
      end

      it "should add the new project to the Projects page" do
        visit projects_path
        find("ul#projects").should have_content "5D Glasses"
      end
    end

    context "fill in form incorrectly" do
      before do
        click_button "Publish Project"
      end

      it "should display a notification message" do
        find(".alert").should have_content "Please correct the following errors"
      end

      it "should add the new project to the My Projects page" do
        visit my_projects_path
        find("ul#projects").should_not have_content "5D Glasses"
      end

      it "should add the new project to the Projects page" do
        visit projects_path
        find("ul#projects").should_not have_content "5D Glasses"
      end
    end
  end


  describe "Edit Project" do
    before do
      @me = create_user_and_login
    end

    context "my project" do
      before do
        @project = create(:project, user: @me)
        visit edit_my_project_path(@project)
      end

      it "should be on the edit project page" do
        current_path.should == edit_my_project_path(@project)
      end

      it "should update" do
        fill_in :project_title, with: "Foo"
        click_button "Update Project"

        current_path.should == my_projects_path
        find(".alert").text.should == "Project updated."
        page.should have_content "Foo"
      end
    end

    context "another user's project" do
      before do
        @project = create(:project)
        visit edit_my_project_path(@project)
      end

      it "should not be able to access the edit project page" do
        page.status_code.should == 404
        page.should have_content "doesn't exist"
      end
    end
  end

  describe "Destroy project", js: true do
    before do
      create_user_and_login
      add_project
      edit_path = "/my#{current_path}/edit"

      visit my_projects_path
      page.should have_content "5D Glasses"

      visit edit_path
    end

    context "accept confirmation" do
      before do
        page.driver.accept_js_confirms!
        click_button "Delete Project"
      end

      it "should display a confirmation window" do
        page.driver.confirm_messages.should == ["Are you sure?"]
      end

      it "should delete the project" do
        visit my_projects_path
        page.should_not have_content "5D Glasses"
      end
    end

    context "reject confirmation" do
      before do
        page.driver.dismiss_js_confirms!
        click_button "Delete Project"
      end

      it "should display a confirmation window" do
        page.driver.confirm_messages.should == ["Are you sure?"]
      end

      it "should not delete the project" do
        click_button "Delete Project"
        visit my_projects_path
        page.should have_content "5D Glasses"
      end
    end
  end
end
