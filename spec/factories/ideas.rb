FactoryBot.define do
  factory :idea do
    title { Faker::Beer.name }
    description { Faker::Lorem.paragraph }
  end
end
