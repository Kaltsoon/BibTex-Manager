FactoryGirl.define do
  factory :reference do
    name "joku"
    ref_type "book"

  end

  factory :reference_attribute do
    name "title"
    value "val"
  end
  
end