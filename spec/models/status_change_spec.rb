# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusChange, type: :model do
  it { should respond_to(:id) }
  it { should respond_to(:previous_status) }
  it { should respond_to(:next_status) }
  it { should respond_to(:project_id) }
  it { should respond_to(:user_id) }

  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:next_status) }
    it { should_not allow_value('').for(:next_status) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      status_change = FactoryBot.build(:status_change, project:, user:)
      expect(status_change).to be_valid
    end
  end
end
