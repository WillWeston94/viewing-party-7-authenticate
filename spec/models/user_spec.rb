require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password) }
  end 
  
  describe "user with secure password" do
    it 'should have secure password' do
      user = User.new(name: "test", email: "test@email.com", password: "benard", password_confirmation: "benard")
      expect(user).to be_valid
      expect(User.new).to respond_to(:authenticate)
    end
  end
end
