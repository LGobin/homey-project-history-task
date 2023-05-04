# frozen_string_literal: true

module CreateStatusChange
  class Validation

    include ::Validations

    def valid_record?
      return false if invalid_next_status?
      return false if status_not_changed?

      true
    end

    private

    def invalid_next_status?
      attribute_blank?(record: status_change, attribute: :next_status)
    end

    def status_not_changed?
      status_change.next_status == status_change.previous_status
    end

  end
end