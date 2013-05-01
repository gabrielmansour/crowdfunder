require 'spec_helper'

describe "image flows" do
  before do
    @user = create_user_and_login
    @project = create(:project, user: @user)

    visit edit_my_project_path(@project)
    click_link "Manage Images"
  end

  describe "navigation" do
    specify { find(".navbar li.active a").text.should == "My Projects" }
  end

  it "should not have any images yet" do
    page.should_not have_css(".image")
  end

  context "successful upload" do
    before do
      path = Rails.root.join('app', 'assets', 'images', 'rails.png')
      attach_file :image_file, path
      click_button "Upload Image"
    end

    it "should display an uploaded image" do
      all("img.image").should have(1).item
    end

    it "should redirect back to manage images page" do
      current_path.should == my_project_images_path(@project)
    end
  end

  context "unsuccesful upload" do
    before do
      click_button "Upload Image"
    end

    it "should not display any images" do
      page.should_not have_css(".image")
    end

    it "should display an failure alert" do
      find(".alert").text.should == "Image upload failed."
    end

    it "should redirect back to manage images page" do
      current_path.should == my_project_images_path(@project)
    end
  end
end
