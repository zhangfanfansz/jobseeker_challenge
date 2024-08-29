# frozen_string_literal: true

FactoryBot.define do
  factory :tag_match do
    sequence(:taggable_name) { |n| "tag_match_#{n}" } 
  end
end
