class PastQuestionsController < ApplicationController
  before_action :login_required, except: [:index]
  before_action :editor_login_required, only: [:new, :edit, :create, :update]
  before_action :super_login_required, only: [:destroy]

  def index
    @past_questions = PastQuestion.order(:id)
  end

  def search
    @past_questions = PastQuestion.search(search_params).sort_by(params[:sort_method])
    render :index
  end

  def show
    @past_question = PastQuestion.find(params[:id])
    @past_question.views = @past_question.views + 1
    @past_question.save! # エラーを見るために！をつけている。
  end

  def new
    @past_question = PastQuestion.new(added_time: Time.current)
  end

  def edit
    @past_question = PastQuestion.find(params[:id])
    @past_question.year = @past_question.exam_date.year
    @past_question.term = @past_question.exam_date.term
  end

  def create
    @past_question = PastQuestion.new(past_question_params)   # 過去問データを入力内容で新規作成
    @past_question.views = 0                                  # 閲覧数を初期化
    set_exam_date_and_tag
    if @past_question.save! # エラーを見るために！をつけている。後で外す
      @past_question.tags << @tag if @tag
      redirect_to @past_question, notice: '過去問を追加しました。'
    else
      redirect_to :past_questions, notice: '追加に失敗'
      # render "new"
    end
  end

  def update
    @past_question = PastQuestion.find(params[:id])                  # idで過去問データを取得
    @past_question.assign_attributes(past_question_params)           # 入力内容でパラメータを書き換え
    set_exam_date_and_tag
    @past_question.tags << @tag if @tag                              # 過去問データにタグ付け
    if @past_question.save! # エラーを見るためにつけている。あとで外す。
      redirect_to @past_question, notice: '過去問の情報を編集しました。'
    else
      render 'edit', notice: '情報の編集に失敗'
    end
  end

  def destroy
    @past_question = PastQuestion.find(params[:id])
    @past_question.destroy
    redirect_to :past_questions
  end

  private

  def past_question_params
    attrs = [:subject, :kana, :teacher, :uploaded_image]
    params.require(:past_question).permit(attrs)
  end

  def exam_date_params
    params.require(:past_question).permit(:year, :term)
  end

  def tag_params_name
    params.require(:past_question).permit(:tag_name)[:tag_name]
  end

  def search_params
    params.permit(:search_subject, :search_teacher, :search_year, :search_term,
                  :search_tag1, :search_tag2, :search_tag3)
  end

  def set_exam_date_and_tag
    @exam_date = ExamDate.get_exam_date(exam_date_params)  # 試験の日時を重複しないように取得
    @past_question.exam_date = @exam_date if @exam_date    # 過去問データと試験日時を関連付け
    @tag = Tag.get_tag(tag_params_name) if tag_params_name # タグを重複しないように取得
  end

end
