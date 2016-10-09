class Editor::TagsController < Editor::Base
  def index
    @tags = Tag.order('name').paginate(page: params[:page], per_page: 15)
  end

  def search
    @tags = Tag.where("name LIKE ?", "%#{params[:search_name]}%").order(:id).paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def set_tag
    @past_question = PastQuestion.find(params[:past_question_id])
    new_tag = Tag.get_tag(params[:name])
    @past_question.tags << new_tag
    redirect_to [:editor, @past_question], notice: 'タグを追加しました。', status: :see_other
  end

  def untag
    @past_question = PastQuestion.find(params[:past_question_id])
    @past_question.tags.destroy(Tag.find(params[:id]))
    redirect_to [:editor, @past_question], notice: 'タグを削除しました。', status: :see_other
  end
end
