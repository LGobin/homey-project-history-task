# frozen_string_literal: true

module CreateStatusChange
  class EntryPoint

    def initialize(params: {}, user:)
      @action = Action.new(params, user)
    end

    def call
      action.call
    end

    attr_accessor :action

  end
end
  