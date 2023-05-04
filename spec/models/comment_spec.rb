# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do

  it { should respond_to(:id) }
  it { should respond_to(:content) }
  it { should respond_to(:project_id) }
  it { should respond_to(:user_id) }

  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should belong_to(:project) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should_not allow_value('').for(:content) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      comment = FactoryBot.build(:comment, project: project, user: user)
      expect(comment).to be_valid
    end
  end
end