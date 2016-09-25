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
end
