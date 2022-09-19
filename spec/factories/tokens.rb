# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    token { StringId.new.generate }
  end
end
