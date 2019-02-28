FactoryBot.define do
  factory :comment do
    body { "MyCommentBody" }
    post { build(:post) }
  end
end