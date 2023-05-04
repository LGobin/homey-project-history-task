require 'rails_helper'

RSpec.describe CreateComment::Action, type: :action do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:params) do
    ActionController::Parameters.new(content: 'My comment', project_id: project.id)
                                .permit(:content, :project_id)
  end

  describe '#call' do
    subject { described_class.new(params, user.id).call }
    context 'when comment is valid' do
      before do
        allow_any_instance_of(ActionController::Parameters).to receive(:permit)
                                                           .and_return(params)
      end

      it 'creates a comment' do
        expect{ subject }.to change { Comment.count }.by(1)
      end

      it 'returns an empty error object' do
        expect(subject).to be_empty
      end
    end

    context 'when comment is invalid' do
      let(:params) do
        ActionController::Parameters.new(content: '', project_id: project.id)
                                    .permit(:content, :project_id)
      end

      before do
        allow_any_instance_of(ActionController::Parameters).to receive(:permit)
                                                           .and_return(params)
      end

      it 'does not create a comment' do
        expect { subject }.not_to change { Comment.count }
      end

      it 'returns an error object' do
        expect(subject).to be_a(ActiveModel::Errors)
      end
    end
  end
end
