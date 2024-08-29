# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :tag_code_name, uniqueness: true
end
