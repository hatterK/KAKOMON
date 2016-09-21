include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :past_question do
    subject "subject1"
    kana "さぶじぇくといち"
    teacher "先生１"
    views 20
    image { fixture_file_upload("spec/fixtures/img/sample.jpg", "image/jpg") }
  end
end
