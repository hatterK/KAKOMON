class PastQuestionsController < ApplicationController

  def index
    @past_questions = PastQuestion.order(:id)
  end

  def search
    # example => PastQuestion.search({search_subject: "pdf", search_year: 2019, search_term: "term", search_tag1: "tag"})
    @past_questions = PastQuestion.search(search_params)
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
    @past_question = PastQuestion.new(past_question_params)   # 過去問データを入力内容で新規作成
    @exam_date = get_exam_date(exam_date_params)              # 試験の日時を重複しないように取得
    @past_question.views = 0                                  # 閲覧数を初期化
    @past_question.exam_date = @exam_date if @exam_date       # 過去問データと試験日時を関連付け
    @tag = get_tag(tag_params_name) if tag_params_name        # タグを重複しないように取得
    if @past_question.save! # エラーを見るために！をつけている。後で外す
      @past_question.tags << @tag if @tag
      redirect_to @past_question, notice: "過去問を追加しました。"
    else
      redirect_to :past_questions, notice: "追加に失敗"
      # render "new"
    end
  end

  def update
    @past_question = PastQuestion.find(params[:id])                  # idで過去問データを取得
    @past_question.assign_attributes(past_question_params)           # 入力内容でパラメータを書き換え
    @exam_date = get_exam_date(exam_date_params) if exam_date_params # 試験日時のパラメータが存在すれば試験日時を取得
    @past_question.exam_date = @exam_date if @exam_date              # 過去問データと試験日時を関連付け
    @tag = get_tag(tag_params_name) if tag_params_name               # タグを取得
    @past_question.tags << @tag if @tag                              # 過去問データにタグ付け
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
    attrs = [:subject, :kana, :teacher, :added_time, :uploaded_image]
    params.require(:past_question).permit(attrs)
  end

  private
  def exam_date_params
    params.require(:past_question).permit(:year, :term)
  end

  private
  def tag_params_name
    params.require(:past_question).permit(:tag_name)[:tag_name]
  end

  private
  def search_params
    params.permit(:search_subject, :search_teacher, :search_year, :search_term, :search_tag1, :search_tag2, :search_tag3)
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
  def get_tag(name)
    if Tag.exists?(name: name)
      tag = Tag.find_by(name: name)
      tag
    else
      tag = Tag.new(name: name, lock: false)
      if tag.save
        tag
      else
        nil
      end
    end
  end

end
