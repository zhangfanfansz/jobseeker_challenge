# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    sequence(:tag_code_name) { |n| "tag_code_#{n}" }
  end
end
