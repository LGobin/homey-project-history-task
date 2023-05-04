# frozen_string_literal: true

module UpdateProject
  class Action < Validation
  
    def initialize(project_id, params)
      @project_id = project_id
      @params = params
    end

    def call
      project.save if valid_record?

      project.errors
    end

    private

    attr_reader :params, :project_id

    def project
      @project ||= Project.find(project_id) do |p|
                     p.name = params[:name]
                     p.description = params[:description]
                   end
    end

  end
end
  