FactoryBot.define do
  factory :user do
    pseudo { ("A".."Z").to_a.sample(3).join }
  end
end
