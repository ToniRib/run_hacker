FactoryGirl.define do
  factory :location do
    city "Denver"
    state "CO"
    zipcode "80210"
  end

  factory :route do
    starting_latitude 39.67759636
    starting_longitude -104.90062083
    location
    elevation 1655.547
  end
end
