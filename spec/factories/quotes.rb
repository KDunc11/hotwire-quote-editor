# frozen_string_literal: true

FactoryBot.define do
  factory :quote do
    oid { ["q_", StringId.new.generate].join }
    name { Faker::TvShows::RickAndMorty.unique.quote }
  end
end
