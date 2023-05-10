# frozen_string_literal: true

class StatusChange < ApplicationRecord
  belongs_to :project
  belongs_to :user

  validates :next_status, presence: true, allow_blank: false
end
