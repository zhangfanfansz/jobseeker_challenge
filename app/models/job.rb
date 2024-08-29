# frozen_string_literal: true

class Job < ApplicationRecord
  has_many :tag_matches, as: :taggable
  validates :title, presence: true
end
