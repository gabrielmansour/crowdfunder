require 'spec_helper'

describe "Project Flows" do
  describe "navigation" do
    context "on home page" do
      before  { visit "/" }
      specify { current_path.should == root_path }
      specify { find(".navbar li.active a").text.should == "Home" }
    end

    context "on projects page" do
      before  { visit "/projects" }
      specify { current_path.should == projects_path }
      specify { find(".navbar li.active a").text.should == "Projects" }
    end

    context "on project show page" do
      before do
        @project = create(:project)
        visit project_path(@project)
      end

      specify { current_path.should == project_path(@project) }
      specify { find(".navbar li.active a").text.should == "Projects" }
    end
  end

  describe "projects" do
    before do
      @project1 = create(:project, title: "Project 1")
      @project2 = create(:project, title: "Project 2")
      @project3 = create(:project, title: "Project 3")
      visit projects_path
    end

    it "should list projects" do
      page.should have_content("Listing Projects")
    end

    it "should list projects" do
      find("ul#projects").should have_content("Project 1")
      find("ul#projects").should have_content("Project 2")
      find("ul#projects").should have_content("Project 3")
    end

    context "View a Project" do
      before do
        click_link "Project 1"
      end

      it "should be on the project page" do
        current_path.should == project_path(@project1)
      end

      it "should display the project title" do
        find("h1").text.should == "Project 1"
      end

      it "should display the project creator's name" do
        find(".author").text.should == "By Tina Fey"
      end


      describe "pledging" do
        context "user logged in" do
          before do
            create_user_and_login
            visit project_path(@project1)
            click_link "Back This Project"
          end

          it "should allow me to pledge to a project" do
            current_path.should == new_project_pledge_path(@project1)
          end
        end

        context "user not logged in" do
          before do
            click_link "Back This Project"
          end

          it "should prompt me to sign up for an account" do
            current_path.should == login_path
            find(".alert").text.should == "Please log in first."
          end
        end
      end


    end
  end
end
