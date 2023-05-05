# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStatusChange::Action, type: :action do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:next_status) { 'valid status' }

  describe '#call' do
    subject { described_class.new(project.id, next_status, user.id).call }
    context 'when status_change is valid' do

      it 'creates a status_change' do
        expect{ subject }.to change { StatusChange.count }.by(1)
      end

      it 'returns an empty error object' do
        expect(subject).to be_empty
      end

      context 'when next_status has HTML tags' do
        let(:next_status) { 'This is a <strong>strong text</strong>' }

        it 'filters them out' do
          subject
          expect(StatusChange.last).to have_attributes(:next_status => "This is a strong text")
        end
      end
    end

    context 'when status_change is invalid' do
      let(:next_status) { '' }

      it 'does not create a status_change' do
        expect { subject }.not_to change { StatusChange.count }
      end

      it 'returns an error object' do
        expect(subject).to be_a(ActiveModel::Errors)
      end
    end
  end
end
