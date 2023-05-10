# frozen_string_literal: true

module GetProject
  class Action
    def initialize(project_id)
      @project_id = project_id
    end

    def call
      project
    end

    private

    attr_reader :project_id

    def project
      @project ||= Project.find(project_id)
    end
  end
end
