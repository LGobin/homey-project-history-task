# frozen_string_literal: true

module CreateStatusChange
  class Action < Validation

    SANITIZE = [[:next_status, 'full_sanitize']]

    def initialize(project_id, next_status, user_id)
      @project_id = project_id
      @next_status = next_status
      @user_id = user_id
    end

    def call
      sanitize_and_save if valid_record?

      status_change.errors
    end

    private

    attr_reader :project_id, :next_status, :user_id

    def status_change
      @status_change ||= StatusChange.new do |sc|
                       sc.previous_status = project.status
                       sc.next_status = next_status
                       sc.project_id = project_id
                       sc.user_id = user_id
                     end
    end

    def project
      @project ||= Project.find(project_id)
    end

    def sanitize_and_save
      ::Helpers::Sanitizer.new(record: @status_change, attributes: SANITIZE).sanitize!

      status_change.save
    end

  end
end
  