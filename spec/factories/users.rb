# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }

    after(:build) { |u| u.password_confirmation = u.password }
  end
end
