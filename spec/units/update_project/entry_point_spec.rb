# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProject::EntryPoint do
  let(:project) { FactoryBot.create(:project) }
  let(:params) { project }
  let(:action) { instance_double(UpdateProject::Action) }

  describe '#call' do
    subject { described_class.new(project_id: project.id, params:).call }

    context 'when the action is successful' do
      it 'calls the action and returns the comment' do
        expect_any_instance_of(UpdateProject::Action).to receive(:call).and_return(project)
        expect(subject).to eq(project)
      end
    end

    context 'when the action raises an exception' do
      it 'raises an exception' do
        expect_any_instance_of(UpdateProject::Action).to receive(:call).and_raise(StandardError)
        expect { subject }.to raise_error(StandardError)
      end
    end
  end
end
