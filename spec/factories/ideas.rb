FactoryBot.define do
  factory :idea do
    title { Faker::Beer }
    description { Faker::Lorem }
  end
end
