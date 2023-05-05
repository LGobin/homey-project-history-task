# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchProjectHistory::Action do
  let(:project) { create(:project) }
  let(:user) { FactoryBot.create(:user) }
  
  describe '#call' do
    subject { described_class.new(project.id).call }

    context 'when there are comments and status changes for the project' do
      let!(:comment) { create(:comment, project: project, user: user) }
      let!(:comment_2) { create(:status_change, project: project, user: user) }
      let!(:status_change) { create(:status_change, project: project, user: user) }
      let!(:comment_3) { create(:status_change, project: project, user: user) }

      it 'returns an array of comments and status changes sorted by creation date in descending order' do
        expect(subject).to eq([comment_3, status_change, comment_2, comment])
      end
    end

    context 'when there are no comments or status changes for the project' do
      it 'returns an empty array' do
        expect(subject).to eq([])
      end
    end
  end
end
