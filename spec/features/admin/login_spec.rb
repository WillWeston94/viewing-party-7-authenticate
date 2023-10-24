require "rails_helper"

describe "Admin login" do
  describe "happy path" do
    it "I can log in as an admin and get to my dashboard" do
	    admin = User.create(email: "superuser@awesome-site.com",
			                  name: "Superuser",
                        password: "super_secret_passw0rd",
                        role: 2)

      visit new_session_path
      fill_in :email, with: admin.email
      # fill_in :name, with: admin.name
      fill_in :password, with: admin.password
      click_button 'Log In'

      expect(current_path).to eq(admin_dashboard_path)
    end
  end
end

describe "as default user" do
  it 'does not allow default user to see admin dashboard index' do
    user = User.create(email: "fern@gully.com",
                       name: "Default",
                       password: "password",
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_dashboard_path

    expect(page).to have_content("You must be an admin to access this page")
  end
end