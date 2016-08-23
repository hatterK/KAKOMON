class ExamDatesController < ApplicationController
  before_action :login_required

  def index
    @exam_dates = ExamDate.order(year: :desc)
  end

  def show
    @exam_date = ExamDate.find(params[:id])
  end

  def search_by_year
    @exam_dates = ExamDate.search("year", params[:q])
  end

  def search_by_term
    @exam_dates = ExamDate.search("term", params[:q])
  end

end
