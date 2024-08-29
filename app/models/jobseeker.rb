# frozen_string_literal: true

class Jobseeker < ApplicationRecord
  has_many :tag_matches, as: :taggable
  validates :name, presence: true
end
