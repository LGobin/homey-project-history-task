# frozen_string_literal: true

module CreateComment
  class EntryPoint

    def initialize(params: {}, user_id:)
      @action = Action.new(params, user_id)
    end

    def call
      action.call
    end

    attr_accessor :action

  end
end
  