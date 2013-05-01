def create_user_and_login
  visit login_path
  user = create(:user, password: "secret")
  fill_in "Email", with: user.email
  fill_in "Password", with: "secret"
  click_button "Log in"
  user
end
