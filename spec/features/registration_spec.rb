require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: 'password', password_confirmation: 'password')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: 'password'
    fill_in :user_password_confirmation, with: 'password'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end

  describe "user with no name" do
    it 'is invalid without a name' do
      visit '/register'

      
      fill_in :user_email, with: 'BernardTest@email.com'
      fill_in :user_password, with: 'Bernard!'
      fill_in :user_password_confirmation, with: 'Bernard!'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Name can't be blank")
    end
  end
  
  it 'creates new user with password' do
    visit '/register'

    fill_in :user_name, with: 'Bernard'
    fill_in :user_email, with: 'BernardTest@email.com'
    fill_in :user_password, with: 'Bernard!'
    fill_in :user_password_confirmation, with: 'Bernard!'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("Bernard's Dashboard")
  end

  describe "user with no password" do
    it 'is invalid without a password' do
      visit '/register'
      
      fill_in :user_name, with: 'Bernard'
      fill_in :user_email, with: 'BernardTest@email.com'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password can't be blank")
    end
  end

  describe "user with mismatched password and password confirmation" do
    it 'is invalid if passwords do not match' do

      visit '/register'

      fill_in :user_name, with: 'Bernard'
      fill_in :user_email, with: 'BernardTest@email.com'
      fill_in :user_password, with: 'Bernard!'
      fill_in :user_password_confirmation, with: 'Bernard'
      click_button 'Create New User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
