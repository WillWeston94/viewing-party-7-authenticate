require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password2", password_confirmation: "password2")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com", password: "password", password_confirmation: "password")
    user2 = User.create(name: "User Two", email: "user2@test.com", password: "password2", password_confirmation: "password2")

    visit '/'

    click_button "Log In"

    expect(current_path).to eq(new_session_path)

    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_button "Log In"

    expect(page).to have_content("User One's Dashboard")

    visit '/'
    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  describe 'user log in' do
    it 'can log in with valid credentials' do

      user = User.create(name: "User One", email: "test@email.com", password: "password", password_confirmation: "password")

      visit '/'

      click_button "Log In"

      expect(current_path).to eq(new_session_path)

      fill_in :email, with: user.email
      fill_in :password, with: user.password
      click_button "Log In"

      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content("User One's Dashboard")
    end
  end

  describe "user cant log in with incorrect credentials" do
    it 'cant log in with entering credentials' do
      user = User.create(name: "User One", email: "email.com", password: "password", password_confirmation: "password") 

      visit '/'

      click_button "Log In"

      expect(current_path).to eq(new_session_path)
      expect(page).to have_content("Email or password is incorrect")
    end
  end
end
