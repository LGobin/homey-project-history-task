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

  describe '.older_first' do
    let!(:project1) { create(:project, created_at: 1.day.ago) }
    let!(:project2) { create(:project, created_at: 2.days.ago) }
    let!(:project3) { create(:project, created_at: 3.days.ago) }

    it 'returns projects in ascending order by creation date' do
      expect(Project.older_first).to eq([project3, project2, project1])
    end
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
          FactoryBot.create(:status_change, project:, next_status: 'in_progress', user:)
          FactoryBot.create(:status_change, project:, next_status: 'completed', user:)
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
        let(:contributor1) { FactoryBot.create(:user) }
        let(:contributor2) { FactoryBot.create(:user) }

        before do
          FactoryBot.create(:comment, project:, user: contributor1)
          FactoryBot.create(:status_change, project:, user: contributor2)
          FactoryBot.create(:comment, project:, user: contributor2)
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
