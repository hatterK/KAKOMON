class TagsController < ApplicationController
  before_action :login_required

  def index
    @tags = Tag.order('name').paginate(page: params[:page], per_page: 15)
  end

  def search
    unless params[:name] == ''
      @tags = Tag.where("name LIKE ?", "%#{params[:name]}%").order(id: :desc).paginate(page: params[:page], per_page: 15)
      render 'index'
    else
      redirect_to :tags
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def set_tag
    @past_question = PastQuestion.find(params[:past_question_id])
    new_tag = Tag.get_tag(params[:name])
    @past_question.tags << new_tag
    redirect_to @past_question, notice: 'タグを追加しました。', status: :see_other
  end
end
