FactoryBot.define do
  factory :comment do
    commenter { "A fellow dev" }
    body { "I agree !!!" }
    article_id { create(:article, :public).id }

    trait :public do
      status { "public" }
    end
  end
end
