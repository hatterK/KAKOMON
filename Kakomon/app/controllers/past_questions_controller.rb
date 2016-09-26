class PastQuestionsController < ApplicationController
  before_action :login_required, except: [:index]

  def index
    @past_questions = PastQuestion.order(created_at: :desc)
      .limit(30).paginate(page: params[:page], per_page: 15)
  end

  def search
    @past_questions = PastQuestion.search(search_params)
      .sort_by(params[:sort_method]).paginate(page: params[:page], per_page: 15)
  end

  def show
    @past_question = PastQuestion.find(params[:id])
    @past_question.views = @past_question.views + 1
    @past_question.save! # エラーを見るために！をつけている。
    render layout: 'show_past_question'
  end

  private

  def search_params
    params.permit(:search_subject, :search_teacher, :search_year, :search_term,
                  :search_tag1, :search_tag2, :search_tag3)
  end
end
