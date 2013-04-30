require 'spec_helper'

describe "ProjectFlows" do

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
