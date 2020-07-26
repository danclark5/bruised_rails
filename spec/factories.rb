FactoryBot.define do
  
  factory :post do
    title { "This is a title" }
    text { "This is the body of the post" }
    is_live { false }

    trait :live do
      title { "This is a live post" }
      is_live { true }
    end
  end
end
