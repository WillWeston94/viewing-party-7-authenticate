require "rails_helper"

RSpec.describe "Logout" do
  before :each do
    @user = User.create!(name: "benard", email: "benard@email.com", password: "ben")
  end

  describe "As a registered user" do
    it "I can logout" do

      visit new_session_path

      fill_in :email, with: @user.email
      fill_in :password, with: @user.password

      click_button "Log In"

      expect(current_path).to eq(user_path(@user.id))

      click_button "Log Out"

      save_and_open_page
      expect(current_path).to eq("/")
      expect(page).to have_content("You have been logged out")
    end
  end
end