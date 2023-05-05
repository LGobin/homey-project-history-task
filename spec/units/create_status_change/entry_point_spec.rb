# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStatusChange::EntryPoint, type: :service do
  describe "#call" do
    subject { described_class.new(project_id: project.id, next_status: 'valid_status', user_id: user.id).call }
    let(:user) { create(:user) }
    let(:project) { create(:project) }

    context "when the action is successful" do
      it "calls the action and returns the ActiveModel errors" do
        expect_any_instance_of(CreateStatusChange::Action).to receive(:call).and_return(ActiveModel::Errors)
        expect(subject).to eq(ActiveModel::Errors)
      end
    end

    context "when the action raises an exception" do
      it "raises an exception" do
        expect_any_instance_of(CreateStatusChange::Action).to receive(:call).and_raise(StandardError)
        expect { subject.call }.to raise_error(StandardError)
      end
    end
  end
end
