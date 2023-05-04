# frozen_string_literal: true

class ProjectsController < ApplicationController
  respond_to :js, :html

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

  def update
    errors = UpdateProject::EntryPoint.new(project_id: params[:id], params: params[:project]).call

    sc_errors = CreateStatusChange::EntryPoint.new(project_id: params[:id],
                                                   next_status: params[:project][:next_status], 
                                                   user_id: current_user.id).call
    errors.merge!(sc_errors)

    respond_to do |format|
      if errors.any?
        format.js { render 'projects/show', locals: { errors: errors, project: Project.find(params[:id]) } }
      else
        format.js { render js: 'window.top.location.reload(true);' }
      end
    end
  end

end