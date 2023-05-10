# frozen_string_literal: true

module UpdateProject
  class Action < Validation
    SANITIZE = [[:name, 'full_sanitize'],
                [:description, 'script_and_style_sanitize']].freeze

    def initialize(project_id, params)
      @project_id = project_id
      @params = params
    end

    def call
      sanitize_and_save if valid_record?

      project
    end

    private

    attr_reader :project_id, :params

    def project
      @project ||= assign_attributes(Project.find(project_id))
    end

    def assign_attributes(project)
      project.assign_attributes(name: params[:name], description: params[:description])

      project
    end

    def sanitize_and_save
      ::Helpers::Sanitizer.new(record: project, attributes: SANITIZE).sanitize!
      project.save
    end
  end
end
