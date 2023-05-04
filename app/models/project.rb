# frozen_string_literal: true

class Project < ApplicationRecord

  has_many :status_changes
  has_many :comments

  validates :name, presence: true, allow_blank: false

  attr_accessor :next_status

  def status
    return nil if status_changes.empty?

    status_changes.last.next_status
  end

  def contributors # FIX THIS
    return nil if comments.pluck(:user_id).blank? && status_changes.pluck(:user_id).blank?

    User.find((comments.pluck(:user_id) + status_changes.pluck(:user_id)).uniq).count
  end
end