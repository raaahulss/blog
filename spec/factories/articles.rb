FactoryBot.define do
  factory :article do
    title { "Test Article" }
    body { "Test article body" }

    trait :public do
      status { "public" }
    end
  end
end
