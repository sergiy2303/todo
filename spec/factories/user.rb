FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@mailinator.com" }
    password { 'p@ssw0rd' }
  end
end
