# frozen_string_literal: true

class CommentsController < ApplicationController
  respond_to :js

  def create # rubocop:disable Metrics/MethodLength
    comment = CreateComment::EntryPoint.new(params: params[:comment], user_id: current_user.id).call

    respond_to do |format|
      if comment.errors.any?
        format.js do
          render 'projects/show', locals: { project_errors: nil,
                                            status_errors: nil,
                                            comment_errors: comment.errors }
        end
      else
        format.js { render js: 'window.top.location.reload(true);' }
      end
    end
  end
end
