# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProject::Validation do
  let(:project) { FactoryBot.create(:project) }
  let(:user) { FactoryBot.create(:user) }
  let(:params) do
    { name:,
      description: '<script>alert("hello");</script><strong> Strong Text </strong>' }
  end

  describe '#valid_record?' do
    subject { UpdateProject::Action.new(project.id, params).valid_record? }
    let(:name) { 'Valid content' }

    context 'when the project has valid name' do
      it 'returns true' do
        expect(subject).to be_truthy
      end
    end

    context 'when the project has blank name' do
      let(:name) { '' }

      it 'returns false' do
        expect(subject).to be_falsey
      end
    end
  end
end
