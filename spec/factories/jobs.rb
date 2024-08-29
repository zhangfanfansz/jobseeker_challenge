FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "job_#{n}" }
  end
end
