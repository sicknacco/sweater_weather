require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should have_secure_password }
    it { should validate_presence_of :api_key }
    it { should validate_uniqueness_of :api_key }
  end

  describe 'instance methods' do
    it 'can generate an api key' do
      user = User.new(email: 'bob@bob.com', password: 'password', password_confirmation: 'password')
      user.generate_api_key

      expect(user.api_key).to_not be_nil
      expect(user.api_key).to be_a(String)
    end
  end
end