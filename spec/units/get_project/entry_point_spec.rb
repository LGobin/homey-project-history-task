# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetProject::EntryPoint, type: :service do
  let(:project_id) { 1 }
  let(:action) { instance_double('Action', call: true) }

  describe '#call' do
    it 'calls the action' do
      entry_point = described_class.new(project_id: project_id)
      entry_point.action = action
      entry_point.call
      expect(action).to have_received(:call)
    end
  end
end
