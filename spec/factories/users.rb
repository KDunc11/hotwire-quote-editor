FactoryBot.define do
  factory :user do
    company { nil }
    email { Faker::Internet.unique.email }
    encrypted_password { Devise::Encryptor.digest(User, Faker::Internet.password) }
  end
end
