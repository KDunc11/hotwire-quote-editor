FactoryBot.define do
  factory :company do
    name { Faker::Company.unique.name }
    oid { ["c_", StringId.new.generate].join }
  end
end
