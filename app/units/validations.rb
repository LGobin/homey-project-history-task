# frozen_string_literal: true

module Validations
  def attribute_blank?(record:, attribute:)
    return unless record[attribute].blank?

    record.errors.add(attribute.to_s, :blank, message: "Can't be blank")
  end
end
