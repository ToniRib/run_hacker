FactoryGirl.define do
  factory :location do
    city "MyString"
    state "MyString"
    zipcode "MyString"
  end
  factory :route do
    workout nil
    city "MyString"
    state "MyString"
    starting_latitude 1.5
    starting_longitude 1.5
  end
end
