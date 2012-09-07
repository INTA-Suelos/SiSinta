# encoding: utf-8
FactoryGirl.define do
  factory :usuario do
    nombre { generate :cadena_unica }
    email
    password "algún password inolvidable"

    # user_with_posts will create post data after the user has been created
    trait :admin do
      roles { [ create(:rol, :admin) ] }
    end

  end
end
