# frozen_string_literal: true

class CommentsController < ApplicationController
  respond_to :js

  def create
    errors = CreateComment::EntryPoint.new(params: params[:comment], user_id: current_user.id).call

    respond_to do |format|
      if errors.any?
        format.js { render 'projects/show', locals: { errors: errors } }
      else
        format.js { render js: 'window.top.location.reload(true);' }
      end
    end
  end

end