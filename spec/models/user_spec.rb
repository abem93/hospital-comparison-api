require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is not valid without an email' do 
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is valid with email, password, and password confirmation' do
    user = build(:user, password: 'password', password_confirmation: 'password')
    expect(user).to be_valid
  end

  it 'hashes the password using BCrypt' do
    user = create(:user, password: 'password', password_confirmation: 'password')
    
    expect(user.password_digest).not_to eq 'password'
    expect(BCrypt::Password.new(user.password_digest)).to be_truthy
  end
end