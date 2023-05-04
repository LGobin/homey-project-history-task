# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'devise modules' do
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
    it { should respond_to(:remember_created_at) }
    it { should respond_to(:reset_password_sent_at) }
    it { should respond_to(:reset_password_token) }
  end

  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:status_changes).dependent(:destroy) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end
end
