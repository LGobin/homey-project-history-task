# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateProject::Action do
  subject { described_class.new(project.id, params).call }
  let(:project) { FactoryBot.create(:project) }
  let(:params) { { name:, description: } }
  let(:description) { '<script>alert("hello");</script><strong> Strong Text </strong>' }

  describe '#call' do
    context 'when record is valid' do
      let(:name) { 'New <div>Project</div> Name' }

      it 'returns a project without errors' do
        expect(subject).to be_a(Project)
        expect(subject.errors).to be_empty
      end

      it 'filters out HTML tags from name' do
        subject
        expect(Project.find(project.id)).to have_attributes(name: 'New Project Name')
      end

      it 'filters out script and style tags from name' do
        subject
        expect(Project.find(project.id)).to have_attributes(description: '<strong> Strong Text </strong>')
      end
    end

    context 'when record is invalid' do
      let(:name) { '' }

      it 'returns a project with errors' do
        expect(subject).to be_a(Project)
        expect(subject.errors[:name]).to eq(["Can't be blank"])
      end
    end
  end
end
