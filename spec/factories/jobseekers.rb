FactoryBot.define do
  factory :jobseeker do
    sequence(:name) { |n| "jobseeker_#{n}" }
  end
end
