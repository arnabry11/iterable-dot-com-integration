# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }

    after(:build) { |u| u.password_confirmation = u.password }

    trait :with_iterable_user_id do
      iterable_user_id { SecureRandom.uuid }
    end
  end
end
