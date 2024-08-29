# frozen_string_literal: true

class TagMatch < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
