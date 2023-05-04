# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: { case_sensitive: true }

  has_many :status_changes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
