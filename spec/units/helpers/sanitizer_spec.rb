# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Helpers::Sanitizer do
  let(:sanitizer) { described_class.new(record: record, attributes: attributes) }
  let(:record) { { 'name' => 'Record <div>Name</div>',
                   'description' => '<script>alert("hello world")</script>Record <div>Description</div>' } }
  let(:attributes) { [[:name, 'full_sanitize'], [:description, 'script_and_style_sanitize']] }

  describe '#sanitize!' do
    subject { sanitizer.sanitize! }

    it 'removes HTML tags from the specified attributes' do
      expect { subject }.to change { record['name'] }.from('Record <div>Name</div>').to('Record Name')
                        .and change { record['description'] }
                        .from('<script>alert("hello world")</script>Record <div>Description</div>')
                        .to('Record <div>Description</div>')
    end
  end

  describe '#full_sanitize' do
    subject { sanitizer.send(:full_sanitize, record: record, attribute: attribute) }

    context 'when the attribute is blank' do
      let(:record) { { 'name' => '' } }
      let(:attribute) { :name }

      it 'does not change the record' do
        expect { subject }.not_to change { record }
      end
    end

    context 'when the attribute contains HTML' do
      let(:attribute) { :name }

      it 'removes the HTML from the attribute' do
        expect { subject }.to change { record[attribute.to_s] }.from('Record <div>Name</div>')
                                                               .to('Record Name')
      end
    end
  end

  describe '#script_and_style_sanitize' do
    subject { sanitizer.send(:script_and_style_sanitize, record: record, attribute: attribute) }

    context 'when the attribute is blank' do
      let(:attribute) { :name }

      it 'does not change the record' do
        expect { subject }.not_to change { record }
      end
    end

    context 'when the attribute contains script and style tags' do
      let(:attribute) { :description }

      it 'removes the script and style tags from the attribute' do
        expect { subject }.to change { record[attribute.to_s] }
                          .from('<script>alert("hello world")</script>Record <div>Description</div>')
                          .to('Record <div>Description</div>')
      end
    end
  end
end
