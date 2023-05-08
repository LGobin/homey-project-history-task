# frozen_string_literal: true

class ProjectsController < ApplicationController
  respond_to :js, :html

  def index
    @projects = Project.older_first
  end

  def show
    @project = GetProject::EntryPoint.new(project_id: params[:id]).call
    @history_data = FetchProjectHistory::EntryPoint.new(project_id: params[:id]).call
  end

  def update
    project = UpdateProject::EntryPoint.new(project_id: params[:id], params: params[:project]).call

    status_change = CreateStatusChange::EntryPoint.new(project_id: params[:id],
                                                   next_status: params[:project][:next_status], 
                                                   user_id: current_user.id).call
    
    respond_to do |format|
      if project.errors.any? || status_change.errors.any?
        format.js { render 'projects/show', locals: { project_errors: project.errors,
                                                      status_errors: status_change.errors,
                                                      comment_errors: nil,
                                                      project: project } }
      else
        format.js { render js: 'window.top.location.reload(true);' }
      end
    end
  end

end