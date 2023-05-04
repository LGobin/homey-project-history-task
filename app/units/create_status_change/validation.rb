# frozen_string_literal: true

module CreateStatusChange
  class Validation

    include ::Validations

    def valid_record?
      return false unless valid_content?

      true
    end

    private

    def valid_content?
      attribute_blank?(record: comment, attribute: :content)
    end

  end
end