# 0.upto(30) do |idx|
#   exam = ExamDate.create(year: (2050-idx), term: "term#{idx % 3}" )
#   PastQuestion.create(
#     subject: "教科#{idx % 4}",
#     kana: "きょうか#{idx % 4}",
#     teacher: "山田　太郎#{idx + 5}",
#     image: "image.jpg",
#     views: (idx + 10),
#     exam_date: exam
#   )
# end
