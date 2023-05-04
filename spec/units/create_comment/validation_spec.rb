# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateComment::Validation do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:params) do
    ActionController::Parameters.new(content: content, project_id: project.id)
                                .permit(:content, :project_id)
  end

  describe '#valid_record?' do
    subject { CreateComment::Action.new(params, user.id).valid_record? }
    let(:content) { 'Valid content' }

    context 'when the comment has valid content' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the comment has blank content' do
      let(:content) { '' }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end
