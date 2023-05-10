# frozen_string_literal: true

module CreateStatusChange
  class EntryPoint
    def initialize(project_id:, next_status:, user_id:)
      @action = Action.new(project_id, next_status, user_id)
    end

    def call
      action.call
    end

    private

    attr_accessor :action
  end
end
