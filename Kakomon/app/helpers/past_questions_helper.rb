module PastQuestionsHelper
  def image_path
    path1 = @past_question.image.current_path
    path1.slice!("#{Rails.root.join("app/assets/images")}/")
    path1
  end
end
