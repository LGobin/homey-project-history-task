# frozen_string_literal: true

module UpdateProject
  class Validation

    include ::Validations

    def valid_record?
      return false if invalid_name?

      true
    end

    private

    def invalid_name?
      attribute_blank?(record: project, attribute: :name)
    end

  end
end