# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetProject::EntryPoint, type: :service do
  let(:project_id) { 1 }
  let(:action) { instance_double('Action', call: true) }

  describe '#call' do
    subject { described_class.new(project_id:) }

    it 'calls the action' do
      expect_any_instance_of(GetProject::Action).to receive(:call)
      subject.call
    end
  end
end
