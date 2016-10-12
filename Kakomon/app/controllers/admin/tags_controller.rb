class Admin::TagsController < Admin::Base
  def index
    @tags = Tag.order('name').where("name LIKE ?", "%#{params[:name]}%").paginate(page: params[:page], per_page: 15)
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def new
    @tag = Tag.new
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.lock = false;
    if @tag.save
      redirect_to [:admin, @tag], notice: "タグを新規作成しました。", status: :see_other
    else
      render 'new', notice: "タグの新規作成に失敗しました。", status: :unprocessable_entity
    end
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.assign_attributes(tag_params)
    @tag.lock = false;
    if @tag.save
      redirect_to [:admin, @tag], notice: "タグの情報を変更しました。", status: :see_other
    else
      render 'edit', notice: "タグの情報の修正に失敗しました。", status: :unprocessable_entity
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to :admin_tags, notice: "タグを削除しました。", status: :see_other
  end

  def set_tag
    @past_question = PastQuestion.find(params[:past_question_id])
    new_tag = Tag.get_tag(params[:name])
    @past_question.tags << new_tag
    redirect_to [:admin, @past_question], notice: 'タグを追加しました。', status: :see_other
  end

  def untag
    @past_question = PastQuestion.find(params[:past_question_id])
    @past_question.tags.destroy(Tag.find(params[:id]))
    redirect_to [:admin, @past_question], notice: 'タグを削除しました。', status: :see_other
  end
end

private

def tag_params
  params.require(:tag).permit(:name)
end
