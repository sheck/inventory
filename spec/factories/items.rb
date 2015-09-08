include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :item do
    name "Stair Car"
    description "It's a car with stairs"
    user

    trait :with_image do
      photo { fixture_file_upload(Rails.root.join('spec', 'support', 'stair_car.jpg'), 'image/jpeg') }
    end
  end
end
