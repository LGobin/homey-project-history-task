# frozen_string_literal: true

class Project < ApplicationRecord

  has_many :status_changes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true, allow_blank: false

  attr_accessor :next_status

  scope :older_first, -> { order('created_at ASC') }

  def status
    return nil if status_changes.empty?

    status_changes.last.next_status
  end

  def contributors
    return nil if user_ids.blank?

    user_ids.count
  end

  private

  def user_ids
    (comments.pluck(:user_id) + status_changes.pluck(:user_id)).uniq
  end
end