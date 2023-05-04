# frozen_string_literal: true

class ProjectsController < ApplicationController # FIX THIS

  def index
    @projects = Project.all
  end

  def show
    @comment = Comment.new
    @project = Project.find(params[:id])
    comments = @project.comments
    status_changes = @project.status_changes

    @history_data = (comments + status_changes).sort_by(&:created_at).reverse
  end

  def create

  end

  def update
    @project = Project.find(params[:id])

    if @project.update(name: params[:project][:name], description: params[:project][:description])
      flash[:notice] = "Project was successfully edited."
    else
      flash[:alert] = "Something went wrong."
    end

    status_change = StatusChange.new(project_id: @project.id, user: current_user, previous_status: @project.status, next_status: params[:project][:next_status])

    unless @project.status == params[:project][:next_status]
      unless status_change.save
        flash[:alert] = "Status can't be blank."
      end
    end
    redirect_to request.referrer
  end
end