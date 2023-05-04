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

    def sanitize_and_save
      ::Helpers::Sanitizer.new(record: @project, attributes: SANITIZE).sanitize!
      project.save
    end

  end
end
  