class Editor::PastQuestionsController < Editor::Base
  def index
    @past_questions = PastQuestion.order(:id)
      .paginate(page: params[:page], per_page: 15)
  end

  def search
    @past_questions = PastQuestion.search(search_params)
      .sort_by(params[:sort_method]).paginate(page: params[:page], per_page: 15)
    set_show_columns
    render :index
  end

  def show
    @past_question = PastQuestion.find(params[:id])
    @past_question.views = @past_question.views + 1
    @past_question.save
  end

  def new
    @past_question = PastQuestion.new
  end

  def edit
    @past_question = PastQuestion.find(params[:id])
    @past_question.year = @past_question.exam_date.year
    @past_question.term = @past_question.exam_date.term
  end

  def create
    @past_question = PastQuestion.new(past_question_params('create')) # 過去問データを入力内容で新規作成
    @past_question.views = 0                                          # 閲覧数を初期化
    @past_question.pub = true
    set_exam_date_and_tag
    if @past_question.save
      @past_question.tags << @tag if @tag
      redirect_to [:editor, @past_question], notice: "過去問を追加しました。", status: :see_other
    else
      render "new", notice: "追加に失敗", status: :unprocessable_entity
    end
  end

  def update
    @past_question = PastQuestion.find(params[:id])                  # idで過去問データを取得
    @past_question.assign_attributes(past_question_params('update')) # 入力内容でパラメータを書き換え
    set_exam_date_and_tag
    @past_question.tags << @tag if @tag                              # 過去問データにタグ付け
    if @past_question.save
      redirect_to [:editor, @past_question], notice: "過去問の情報を編集しました。", status: :see_other
    else
      render "edit", notice: "情報の編集に失敗", status: :unprocessable_entity
    end
  end

  private

  def past_question_params(action)
    attrs = [:subject, :kana, :teacher]
    attrs << :image if action == 'create'
    attrs << :pub if action == 'update'
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

  def set_show_columns
    @show_subject = params[:show_subject]
    @show_teacher = params[:show_teacher]
    @show_term = params[:show_term]
    @show_year = params[:show_year]
    @show_views = params[:show_views]
    @show_pub = params[:show_pub]
    @show_tag = params[:show_tag]
    @show_created_at = params[:show_created_at]

    if @show_subject.nil? && @show_teacher.nil? && @show_term.nil? && @show_year.nil? && @show_views.nil? && @show_pub.nil? && @show_tag.nil? && @show_created_at.nil?
      @show_subject = true
      @show_teacher = true
      @show_term = true
      @show_year = true
      @show_views = true
      @show_pub = true
      @show_tag = true
      @show_created_at = true
    end
  end
end
