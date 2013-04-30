require 'spec_helper'

describe "User flows" do
  describe "navigation" do
    it "should show a sign up link" do
      visit root_path
      click_link "Sign up"
      current_path.should == new_user_path
    end
  end

  describe "user registration" do

    context "all fields filled in correctly" do
      before do
        visit new_user_path
        fill_in "First Name", with: "Akira"
        fill_in "Last Name", with: "Kurosawa"
        fill_in "Email", with: "akira@example.com"
        fill_in "Password", with: "secret"
        click_button "Sign Up"
      end

      specify { current_path.should == root_path }
      specify { find(".alert").should have_content("Account created.") }
      specify { page.should_not have_content "Sign up" }
      specify { page.should have_link("Log out") }
      specify { page.should have_content("Logged in as Akira Kurosawa") }

      it "should create a new user" do
        User.count.should == 1
      end
    end

    context "fields not filled in correctly" do
      before do
        visit new_user_path
        click_button "Sign Up"
      end

      specify { find(".alert").should have_content("Please correct the following errors") }

      it "should display 4 errors" do
        all(".alert ul li").should have(4).items
      end

      specify { page.should_not have_content("Account created.") }
      specify { find(".navbar").should have_content("Sign up") }
      specify { page.should_not have_link("Log out") }
      specify { page.should_not have_content("Logged in as") }

      it "should not create a new user" do
        User.count.should == 0
      end

      it "should display the signup form" do
        page.should have_css("form#new_user")
      end
    end
  end
end
