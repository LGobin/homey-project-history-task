# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateComment::EntryPoint, type: :service do
  describe '#call' do
    subject { described_class.new(params: comment, user_id: user.id).call }
    let(:user) { create(:user) }
    let(:project) { create(:project) }
    let(:comment) { build(:comment, project:) }

    context 'when the action is successful' do
      it 'calls the action and returns the comment' do
        expect_any_instance_of(CreateComment::Action).to receive(:call).and_return(comment)
        expect(subject).to eq(comment)
      end
    end

    context 'when the action raises an exception' do
      it 'raises an exception' do
        expect_any_instance_of(CreateComment::Action).to receive(:call).and_raise(StandardError)
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
