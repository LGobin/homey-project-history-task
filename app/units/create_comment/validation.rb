# frozen_string_literal: true

module CreateComment
  class Validation

    include ::Validations

    def valid_record?
      return false if invalid_content?

      true
    end

    private

    def invalid_content?
      attribute_blank?(record: comment, attribute: :content)
    end

  end
end