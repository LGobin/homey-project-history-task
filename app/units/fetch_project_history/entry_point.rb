# frozen_string_literal: true

module FetchProjectHistory
  class EntryPoint
    def initialize(project_id:)
      @action = Action.new(project_id)
    end

    def call
      action.call
    end

    private

    attr_accessor :action
  end
end
