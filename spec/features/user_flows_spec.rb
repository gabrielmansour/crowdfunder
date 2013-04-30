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


  describe "login" do
    before do
      visit root_path
      click_link "Log in"
    end

    it "should display the login page" do
      current_path.should == login_path
    end

    context "successful" do
      before { create_user_and_login }

      specify { find(".alert").should have_content("Welcome back.") }
      specify { page.should_not have_content "Sign up" }
      specify { page.should have_link("Log out") }
      specify { page.should have_content("Logged in as Tina Fey") }
    end

    context "unsuccessful" do
      before do
        visit login_path
        click_button "Log in"
      end

      specify { find(".alert").should have_content("Invalid email or password.") }

      specify { page.should_not have_content("Welcome back.") }
      specify { page.should have_content "Sign up" }
      specify { page.should_not have_link("Log out") }
      specify { page.should_not have_content("Logged in as") }
    end
  end

  describe "logout" do
    before do
      create_user_and_login
      click_link "Log out"
    end

    specify { page.should_not have_content("Log out") }
    specify { find(".alert").should have_content("You have been logged out.") }
    specify { page.should have_content("Sign up") }
    specify { page.should_not have_content("Logged in as") }
  end
end

def create_user_and_login
  visit login_path
  user = create(:user, password: "secret")
  fill_in "Email", with: user.email
  fill_in "Password", with: "secret"
  click_button "Log in"
end
