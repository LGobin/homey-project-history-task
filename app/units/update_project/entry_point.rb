# frozen_string_literal: true

module UpdateProject
  class EntryPoint

    def initialize(project_id:, params: {})
      @action = Action.new(project_id, params)
    end

    def call
      action.call
    end

    attr_accessor :action

  end
end
  