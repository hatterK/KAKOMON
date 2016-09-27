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

  def sort_option
    case @sort
    when 'year_desc' then [["年度降順","year_desc"],["追加日時","created_at"],["年度昇順", "year_asce"],["閲覧数", "views"],["教科名","subject"],["教授名", "teacher"]]
    when 'year_asce' then [["年度昇順", "year_asce"],["追加日時","created_at"],["年度降順","year_desc"],["閲覧数", "views"],["教科名","subject"],["教授名", "teacher"]]
    when 'views' then [["閲覧数", "views"],["追加日時","created_at"],["年度降順","year_desc"],["年度昇順", "year_asce"],["教科名","subject"],["教授名", "teacher"]]
    when 'subject' then [["教科名","subject"],["追加日時","created_at"],["年度降順","year_desc"],["年度昇順", "year_asce"],["閲覧数", "views"],["教授名", "teacher"]]
    when 'teacher' then [["教授名", "teacher"],["追加日時","created_at"],["年度降順","year_desc"],["年度昇順", "year_asce"],["閲覧数", "views"],["教科名","subject"]]
    else [["追加日時","created_at"],["年度降順","year_desc"],["年度昇順", "year_asce"],["閲覧数", "views"],["教科名","subject"],["教授名", "teacher"]]
    end
  end
end
