class PastQuestionsController < ApplicationController

  def index
    @past_questions = PastQuestion.order(:id)
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
    @past_question.save! # エラーを見るために！をつけている。
  end

  def new
    @past_question = PastQuestion.new( added_time: Time.current )
  end

  def edit
    @past_question = PastQuestion.find(params[:id])
    @past_question.year = @past_question.exam_date.year
    @past_question.term = @past_question.exam_date.term
  end

  def create
    # @date = ExamDate.create(exam_date_params)
    @past_question = PastQuestion.new(past_question_params)
    @exam_date = get_exam_date(exam_date_params)
    @past_question.views = 0
    @past_question.exam_date = @exam_date if @exam_date

    #a @past_question = set_tag(@past_question, tag_params) if @past_question
    # unless set_exam_date(@past_question, exam_date_、params)
    #   redirect_to :past_questions, notice: "似る"
    # end

    if @past_question.save! # エラーを見るために！をつけている。後で外す
      redirect_to @past_question, notice: "過去問を追加しました。"
    else
      redirect_to :past_questions, notice: "追加に失敗"
      # render "new"
    end
  end

  def update
    @past_question = PastQuestion.find(params[:id])
    @past_question.assign_attributes(past_question_params)
    @exam_date = get_exam_date(exam_date_params)
    @past_question.exam_date = @exam_date if @exam_date

    if @past_question.save! # エラーを見るためにつけている。あとで外す。
      redirect_to @past_question, notice: "過去問の情報を編集しました。"
    else
      render "edit", notice: "情報の編集に失敗"
    end
  end

  def destroy
    @past_question = PastQuestion.find(params[:id])
    @past_question.destroy
    redirect_to :past_questions
  end

  private
  def past_question_params
    attrs = [:subject, :kana, :teacher, :added_time, :file_path]
    params.require(:past_question).permit(:subject, :kana, :teacher, :file_path, :added_time )
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
  def get_exam_date(exam_params)
    if ExamDate.exists?(exam_params)
      exam_date = ExamDate.find_by(exam_params)
      exam_date
    else
      exam_date = ExamDate.new(exam_params)
      if exam_date.save
        exam_date
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
        past_question
      end
    end
  end

end
