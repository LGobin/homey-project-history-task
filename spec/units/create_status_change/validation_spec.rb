# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStatusChange::Validation do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:next_status) { '' }

  describe '#valid_record?' do
    subject do
      CreateStatusChange::Action.new(project.id, next_status, user.id)
                                .valid_record?
    end
    before do
      FactoryBot.create(:status_change, project:,
                                        user:,
                                        next_status: 'created')
    end

    context 'when next status is blank' do
      it 'returns false' do
        expect(subject).to eq(false)
      end
    end

    context 'when next status is not blank' do
      context 'when next status is the same as previous status' do
        let(:next_status) { 'created' }

        it 'returns false' do
          expect(subject).to eq(false)
        end
      end

      context 'when next status is different from previous status' do
        let(:next_status) { 'in progress' }

        it 'returns true' do
          expect(subject).to eq(true)
        end
      end
    end
  end
end
