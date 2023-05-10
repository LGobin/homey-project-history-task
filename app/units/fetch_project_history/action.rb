# frozen_string_literal: true

module FetchProjectHistory
  class Action
    def initialize(project_id)
      @project_id = project_id
      @data = comments + status_changes
    end

    def call
      sorted_data
    end

    private

    attr_reader :project_id, :data

    def project
      @project ||= Project.find(project_id)
    end

    def comments
      @comments ||= project.comments
    end

    def status_changes
      @status_changes ||= project.status_changes
    end

    def sorted_data
      data.sort_by(&:created_at).reverse
    end
  end
end
