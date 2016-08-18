# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
table_names = %w(past_questions)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds", Rails.env, table_name + ".rb")
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end

# exam_date が存在しなくなるのでこのシードデータは使ってはいけない。
#  past_questions = PastQuestion.create( [
#    {subject: "教科", kana: "きょうか", teacher: "山田　太郎", file_path: "image/8.jpg", views: 10, added_time: "2016-10-20", exam_date_id: 10 },
#    {subject: "教科", kana: "きょうか", teacher: "山田　太郎", file_path: "image/9.jpg", views: 10, added_time: "2016-10-20", exam_date_id: 11 },
#    {subject: "教科", kana: "きょうか", teacher: "山田　太郎", file_path: "image/19.jpg", views: 10, added_time: "2016-10-20", exam_date_id: 12 },
#    {subject: "教科", kana: "きょうか", teacher: "山田　太郎", file_path: "image/20.jpg", views: 10, added_time: "2016-10-20", exam_date_id: 13 }
#    ])
