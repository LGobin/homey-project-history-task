# frozen_string_literal: true

module CreateComment
  class Action < Validation
  
    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      comment.save if valid_record?

      comment.errors
    end

    private

    attr_reader :params, :user

    def comment
      @comment ||= Comment.new(comment_params) do |c|
                     c.user = user
                   end
    end

    def comment_params
      @comment_params ||= params.permit(:content, :project_id)
    end

  end
end
  