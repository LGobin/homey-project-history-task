# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetProject::Action, type: :service do
  let(:project_id) { 1 }

  describe '#call' do
    subject { described_class.new(project_id).call }

    context 'when project exists' do
      let!(:project) { create(:project, id: project_id) }

      it 'returns the project' do
        expect(subject).to eq project
      end
    end

    context 'when project does not exist' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
