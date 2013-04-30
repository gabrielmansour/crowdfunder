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

  end

  describe "GET /projects" do
    it "should list projects" do
      visit projects_path
      page.should have_content("Listing Projects")
    end

    it "should list projects" do
      create(:project)
      visit projects_path
      find("ul#projects").should have_content("5D Glasses")
    end
  end
end
