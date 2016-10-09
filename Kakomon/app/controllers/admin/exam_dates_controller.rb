class Admin::ExamDatesController < Admin::Base
  def index
    @exam_dates = ExamDate.order(year: :desc).paginate(page: params[:page], per_page: 15)
  end

  def show
    @exam_date = ExamDate.find(params[:id])
  end

  def new
    @exam_date = ExamDate.new
  end

  def edit
    @exam_date = ExamDate.find(params[:id])
  end

  def create
    @exam_date = ExamDate.new(exam_date_params)
    if @exam_date.save
      redirect_to [:admin, @exam_date], notice: '試験日時を追加しました。', status: :see_other
    else
      render 'new', notice: '試験日時の追加に失敗しました。', status: :unprocessable_entity
    end
  end

  def update
    @exam_date = ExamDate.find(params[:id])
    @exam_date.assign_attributes(exam_date_params)
    if @exam_date.save
      redirect_to [:admin, @exam_date], notice: '試験日時を変更しました。', status: :see_other
    else
      render 'edit', notice: '試験日時の修正に失敗しました。', status: :unprocessable_entity
    end
  end

  def destroy
    @exam_date = ExamDate.find(params[:id])
    @exam_date.destroy
    redirect_to :admin_exam_dates, notice: '試験日時を削除しました。', status: :see_other
  end

  def search
    @exam_dates = ExamDate.search(params[:search_year], params[:search_term]).paginate(page: params[:page], per_page: 15)
    @term = params[:search_term]
    render 'index'
  end

  private

  def exam_date_params
    attrs = [:year, :term]
    params.require(:exam_date).permit(attrs)
  end
end
