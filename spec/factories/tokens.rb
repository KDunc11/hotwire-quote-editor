FactoryBot.define do
  factory :token do
    token { StringId.new.generate }
  end
end
