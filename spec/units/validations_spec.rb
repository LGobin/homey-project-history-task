# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validations do
  class ValidationTest
    include Validations
    attr_accessor :record, :errors

    def initialize(record)
      @record = record
    end
  end

  describe '#attribute_blank?' do
    let(:record) { FactoryBot.build(:project, name: name) }
    subject { ValidationTest.new(record) }

    context 'when the attribute is blank' do
      let(:name) { '' }
      before { allow(record).to receive(:[]).and_return('') }

      it 'adds an error to the record' do
        subject.attribute_blank?(record: record, attribute: :name)
        expect(record.errors[:name]).to include("Can't be blank")
      end
    end

    context 'when the attribute is not blank' do
      let(:name) { 'Valid project name' }
      before { allow(record).to receive(:[]).and_return('value') }

      it 'does not add an error to the record' do
        subject.attribute_blank?(record: record, attribute: :name)
        expect(record.errors[:name]).to be_empty
      end
    end
  end
end
