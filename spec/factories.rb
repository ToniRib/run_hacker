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

  factory :user do
    token "3ea179759b2da90f16388381b90d4ce71e9e7648e"
    provider "mapmyfitness"
    uid 9483291
    display_name "User"
    username "username"
    email "example@example.com"
    image "http://a3.files.biography.com/image/upload/c_fit,cs_srgb," \
          "dpr_1.0,h_1200,q_80,w_1200/MTE5NTU2MzE2NjYxNTE1Nzg3.jpg"
  end
end
