FactoryGirl.define do
  factory :invite do
    user_id '327592a3-04a0-4907-a174-588aa64abbba'
    id 'a3db9a59-594c-4bd1-917a-7766cbca09d7'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end

end
