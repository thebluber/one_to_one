FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    sequence(:email) { |n| "#{first_name}.#{last_name + n.to_s}@student.uni-tuebingen.de".downcase }
    password "12345678"
  end

  factory :student do
    user
  end

  factory :mentor do
    user
  end

  factory :course_bucket do
    student
  end

  factory :active_course do
    sequence(:title) { |n| "Info#{n}" }
    active true
  end

  factory :inactive_course do
    sequence(:title) { |n| "Mathe#{n}" }
    active false
  end
end
