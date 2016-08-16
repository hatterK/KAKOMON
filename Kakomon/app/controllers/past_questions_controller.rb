class PastQuestionsController < ApplicationController

  def index
    @past_questions = PastQuestion.order(added_time: :desc)
  end

  def search
    @past_questions = PastQuestion.search(params[:q])
    render :index
  end

  def sort
    @past_questions = PastQuestion.sort_by(params[:q], true)
    render :index
  end

  def show
    @past_question = PastQuestion.find(params[:id])
    @past_question.views = @past_question.views + 1
  end

  def new
    @past_question = PastQuestion.new( added_time: Time.current )
  end

  def edit
    @past_question = PastQuestion.find(params[:id])
  end

  def create
    @past_question = PastQuestion.new(past_question_params)
    @past_question.views = 0
    @past_question = set_exam_date(@past_question, exam_date_params)
    @past_question = set_tag(@past_question, tag_params) if @past_question
    if @past_question && @past_question.save
      redirect_to @past_question, notice: "過去問を追加しました。"
    else
      render "new"
    end
  end

  def update
    @past_question = PastQuestion.find(params[:id])
    @past_question.assign_attributes(past_question_params)
    @past_question = set_exam_date(@past_question, exam_date_params)
    if @past_question && @past_question.save
      redirect_to @past_question, notice: "過去問の情報を編集しました。"
    else
      render "edit"
    end
  end

  def destroy
    @past_question = PastQuestion.find(params[:id])
    @past_question.destroy
    redirect_to :past_questions
  end

  private
  def past_question_params
    attrs = [:subject, :kana, :teacher, :added_time]
    params.require(:past_question).permit(attrs)
  end

  private
  def exam_date_params
    params.require(:past_question).permit(:year, :term)
  end

  private
  def tag_params
    params.require(:past_question).permit(:tag_name)
  end

  private
  def set_exam_date(past_question, exam_params)
    if ExamDate.exists?(exam_params)
      @exam_date = ExamDate.find_by(exam_params)
      past_question.exam_date = @exam_date
      past_question
    else
      @exam_date = ExamDate.new(exam_params)
      if @exam_date.save
        past_question.exam_date = @exam_date
        past_question
      else
        nil
      end
    end
  end

  private
  def set_tag(past_question, tag_p)
    if Tag.exists?(name: tag_p[:tag_name])
      @tag = Tag.find_by(tag_p)
      past_question.tags << @tag
      past_question
    else
      @tag = Tag.new(tag_p)
      if @tag.save
        past_question.tags << @tag
        past_question
      else
        nil
      end
    end
  end
end
