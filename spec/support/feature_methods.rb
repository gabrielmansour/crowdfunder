def create_user_and_login
  if page.driver.class == Capybara::RackTest::Driver
    user = create(:user, email: "tina@example.com", password: "secret")
  else
    visit new_user_path
    fill_in "First Name", with: "Tina"
    fill_in "Last Name", with: "Fey"
    fill_in "Email", with: "tina@example.com"
    fill_in "Password", with: "secret"
    click_button "Sign Up"
    user = User.last
  end
  visit login_path
  fill_in "Email", with: "tina@example.com"
  fill_in "Password", with: "secret"
  click_button "Log in"
  user
end

def add_project
  visit new_my_project_path
  project= build(:project)
  fill_in :project_title, with: project.title
  fill_in :project_teaser, with: project.teaser
  fill_in :project_description, with: project.description
  fill_in :project_goal, with: project.goal
  click_button "Publish Project"
end

