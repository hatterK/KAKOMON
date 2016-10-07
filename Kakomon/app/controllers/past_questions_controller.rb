class PastQuestionsController < ApplicationController
  before_action :login_required, except: [:index]

  def index
    @past_questions = PastQuestion.where(pub: true).order(created_at: :desc)
      .limit(30).paginate(page: params[:page], per_page: 15)
  end

  def search
    @past_questions = PastQuestion.where(pub: true).search(search_params)
      .sort_by(params[:sort_method]).paginate(page: params[:page], per_page: 15)
    @sort = params[:sort_method]
    @term = params[:search_term]
    @faculty = params[:search_tag1]
  end

  def show
    @past_question = PastQuestion.find(params[:id])
    if @past_question.pub
      @past_question.views = @past_question.views + 1
      @past_question.save
      render layout: 'show_past_question'
    else
      redirect_to :past_questions, notice: "この過去問は公開されていません。"
    end
  end

  private

  def search_params
    params.permit(:search_subject, :search_teacher, :search_year, :search_term,
                  :search_tag1, :search_tag2, :search_tag3)
  end
end
