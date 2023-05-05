# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }

  describe 'associations' do
    it { should have_many(:status_changes).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance methods' do
    describe '#status' do
      context 'when no status changes exist' do
        it 'returns nil' do
          expect(project.status).to be_nil
        end
      end

      context 'when status changes exist' do
        it 'returns the latest next_status' do
          FactoryBot.create(:status_change, project: project, next_status: 'in_progress', user: user)
          FactoryBot.create(:status_change, project: project, next_status: 'completed', user: user)
          expect(project.status).to eq('completed')
        end
      end
    end

    describe '#contributors' do
      context 'when no comments or status changes exist' do
        it 'returns nil' do
          expect(project.contributors).to be_nil
        end
      end

      context 'when comments or status changes exist' do
        let(:contributor_1) { FactoryBot.create(:user) }
        let(:contributor_2) { FactoryBot.create(:user) }

        before do
          FactoryBot.create(:comment, project: project, user: contributor_1)
          FactoryBot.create(:status_change, project: project, user: contributor_2)
          FactoryBot.create(:comment, project: project, user: contributor_2)
        end

        it 'returns the number of unique contributors' do
          expect(project.contributors).to eq(2)
        end
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      project = FactoryBot.build(:project)
      expect(project).to be_valid
    end
  end
end
