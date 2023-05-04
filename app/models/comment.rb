# frozen_string_literal: true

class Comment < ApplicationRecord

  belongs_to :project
  belongs_to :user

  validates :content, presence: true, allow_blank: false

end