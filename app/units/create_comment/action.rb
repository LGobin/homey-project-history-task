# frozen_string_literal: true

module CreateComment
  class Action < Validation
  
    def initialize(params, user_id)
      @params = params
      @user_id = user_id
    end

    def call
      comment.save if valid_record?

      comment
    end

    private

    attr_reader :params, :user_id

    def comment
      @comment ||= Comment.new(comment_params) do |c|
                     c.user_id = user_id
                   end
    end

    def comment_params
      @comment_params ||= params.permit(:content, :project_id)
    end

  end
end
  