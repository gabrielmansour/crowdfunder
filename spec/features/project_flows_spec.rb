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

  describe "pagination" do
    before do
      50.times { |i| create(:project, title: "Project ##{i+1}") }
      visit projects_path
    end

    it "should show up to 8 projects at a time" do
      all("ul#projects li").should have(8).items
    end

    it "should display pagination info" do
      page.should have_content "Displaying projects 1 - 8 of 50 in total"
    end

    it "should display the paginator" do
      page.should have_css(".pagination")
    end

    it "should display the most recently created project first" do
      first("ul#projects li a").text.should == "Project #50"
    end

    describe "navigating using the paginator" do
      before { find(".pagination").click_link("2") }

      it "should display the next batch of projects" do
        all("ul#projects li a").map(&:text).should == (35..42).map{|i| "Project ##{i}"}.reverse
      end

      it "should not display projects from page 1" do
        find("ul#projects").should_not have_content "Project #43"
      end

      it "should not display projects from page 3" do
        find("ul#projects").should_not have_content "Project #34"
      end
    end
  end


  describe "projects" do
    before do
      @project_owner = create(:user, email: "jim@example.com")
      @project1 = create(:project, title: "Project 1", user: @project_owner)
      @project2 = create(:project, title: "Project 2", user: @project_owner)
      @project3 = create(:project, title: "Project 3", user: @project_owner)
      visit projects_path
    end

    it "should list projects" do
      page.should have_content("Projects")
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

          context "amount filled in" do
            before do
              fill_in "Amount", with: "500"
              click_button "Pledge!"
            end

            it "should add a pledge to the project" do
              current_path.should == project_path(@project1)
              find(".alert").text.should == "Hooray! You pledged $500!"
              @project1.should have(1).pledges
              @project1.pledges.first.amount.should == 500
            end

            it "should sent email to project owner" do
              should have_sent_email.to("jim@example.com")
                .from("crowdfunder@example.com")
                .with_subject("Someone has backed your project!")
            end
          end

          context "amount not filled in" do
            it "should add a pledge to the project" do
              fill_in "Amount", with: ""
              click_button "Pledge!"

              find(".alert").should have_content "Amount must be a number greater than 0"
              @project1.should have(0).pledges
            end
          end

          it "should not send email" do
            should_not have_sent_email
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


  describe "projects search" do
    before do
      @project1 = create(:project, title: "Tintin Theme Park")
      @project2 = create(:project, title: "Park Avenue Festival")
      @project3 = create(:project, title: "Library Expansion")

      visit projects_path
      all("ul#projects li a").map(&:text).should == ["Library Expansion", "Park Avenue Festival", "Tintin Theme Park"]
    end

    it "should only show projects whose name matches the search query" do
      fill_in "Search", with: "park"
      click_button "Search"

      all("ul#projects li a").map(&:text).should == ["Park Avenue Festival", "Tintin Theme Park"]
    end

  end
end
