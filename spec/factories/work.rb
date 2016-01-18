FactoryGirl.define do
  factory :work do
    description 'bla bla car'
  end

  factory :completed_work, parent: :work do
    complete true
  end
end
