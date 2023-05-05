# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchProjectHistory::EntryPoint do
  let(:project) { FactoryBot.create(:project) }
  let(:action) { subject.action }

  describe "#call" do
    subject { described_class.new(project_id: project.id) }

    it "calls #call on the action" do
      expect(action).to receive(:call)
      subject.call
    end
  end
end
