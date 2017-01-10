FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'muffins1'
    password_confirmation 'muffins1'
    username { Faker::Internet.user_name }
    team_id 'a24a70ea-a6a2-11e5-9929-470552acbb53'
    factory :admin do
      email 'js@js.com'
      username 'jsmith'
      id '327592a3-04a0-4907-a174-588aa64abbba'
      after(:create) { |user| user.add_role(:admin) }
    end
    factory :manager do
      after(:create) { |user| user.add_role(:manager) }
    end
    factory :employee do
      after(:create) { |user| user.add_role(:employee) }
    end
  end
end
