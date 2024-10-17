# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Adel' }
    surname { 'Safin' }
    patronymic { 'Isildurovish' }
    email { 'safin@example.com' }
    age { 36 }
    nationality { 'Tatarin' }
    country { 'Russia' }
    gender { 'male' }

    after(:create) do |user|
      create_list(:skill, 3, users: [user])
      create_list(:interest, 3, users: [user])
    end
  end
end
