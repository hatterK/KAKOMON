module PastQuestionsHelper
  def base64_image_data
    # path1 = @past_question.image.current_path
    # path1.slice!("#{Rails.root.join("app/assets/images")}/")
    # path1
    ext = File.extname(@past_question.image.current_path)
    if(ext == '.pdf')
      'data:application/pdf;base64,' + Base64.strict_encode64(File.binread(@past_question.image.current_path))
    elsif(ext == '.jpg' || ext == '.jpeg')
      'data:image/jpg;base64,' + Base64.strict_encode64(File.binread(@past_question.image.current_path))
    elsif(ext == 'png')
      'data:image/png;base64,' + Base64.strict_encode64(File.binread(@past_question.image.current_path))
    end
  end

  def faculty_option
    [["条件なし",""],["全学共通科目","全学共通科目"],["文学部","文学部"],["教育学部","教育学部"],["法学部","法学部"],
    ["経済学部","経済学部"],["理学部","理学部"],["医学部医学科","医学部医学科"],["医学部人間健康科学科","医学部人間健康科学科"],
    ["薬学部","薬学部"],["工学部","工学部"],["農学部","農学部"],["総合人間学部","総合人間学部"]]
  end

  def sort_option
    [["追加日時","created_at"],["年度降順","year_desc"],["年度昇順", "year_asce"],["閲覧数", "views"],["教科名","subject"],["教授名", "teacher"]]
  end
end
