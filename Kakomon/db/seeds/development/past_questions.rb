

0.upto(30) do |idx|

  exam = ExamDate.create(year: (2050-idx), term: "term#{idx % 3}" )
  pasque = PastQuestion.create(
    subject: "教科#{idx % 4}",
    kana: "きょうか#{idx % 4}",
    teacher: "山田　太郎#{idx + 5}",
    file_path: "image/#{idx+1}.jpg",
    views: (idx+10),
    added_time: "2020-10-11",
    exam_date: exam
    )


end
