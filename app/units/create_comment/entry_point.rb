# frozen_string_literal: true

module CreateComment
  class EntryPoint
    def initialize(user_id:, params: {})
      @action = Action.new(params, user_id)
    end

    def call
      action.call
    end

    private

    attr_accessor :action
  end
end
