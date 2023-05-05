# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProject::Action do
  subject { described_class.new(project.id, params) }
  let(:project) { FactoryBot.create(:project) }
  let(:params) { { name: name, description: description } }
  let(:description) { '<script>alert("hello");</script><strong> Strong Text </strong>' }

  describe '#call' do
    context 'when record is valid' do
      let(:name) { 'New <div>Project</div> Name' }

      before do
        allow(subject).to receive(:valid_record?).and_return(true)
      end

      it 'calls sanitize_and_save' do
        expect(subject).to receive(:sanitize_and_save)
        subject.call
      end

      it 'returns no errors' do
        expect(subject.call).to be_empty
      end

      it 'filters out HTML tags from name' do
        subject.call
        expect(Project.find(project.id)).to have_attributes(:name => 'New Project Name')
      end

      it 'filters out script and style tags from name' do
        subject.call
        expect(Project.find(project.id)).to have_attributes(:description => '<strong> Strong Text </strong>')
      end
    end

    context 'when record is invalid' do
      let(:name) { '' }

      it 'does not call sanitize_and_save' do
        expect(subject).not_to receive(:sanitize_and_save)
        subject.call
      end

      it 'returns errors' do
        expect(subject.call[:name]).to eq(["Can't be blank"])
      end
    end
  end
end
