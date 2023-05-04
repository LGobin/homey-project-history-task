# frozen_string_literal: true

module Helpers
  class Sanitizer
    SCRIPT = '/<script.*?>[\s\S]*<\/script>/'.to_regexp.freeze
    STYLE = '/<style.*?>[\s\S]*<\/style>/'.to_regexp.freeze
    HTML = '/(&nbsp;|<\/?[^>]+>)/'.to_regexp.freeze

    def initialize(record:, attributes:)
      @record = record
      @attributes = attributes
    end

    def sanitize!
      attributes.each { |attr| send(attr.last, record: record, attribute: attr.first) }

      return record
    end

    attr_accessor :record, :attributes

    private

    def full_sanitize(record:, attribute:)
      return if attribute.blank?

      record[attribute.to_s] = record[attribute.to_s].gsub(HTML, '')
    end

    def script_and_style_sanitize(record:, attribute:)
      return if attribute.blank?

      record[attribute.to_s] = record[attribute.to_s].gsub(SCRIPT, '')
                                                     .gsub(STYLE, '')
    end
  end
end