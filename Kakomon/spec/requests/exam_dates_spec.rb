require 'rails_helper'

RSpec.describe "ExamDates", type: :request do
  describe 'ステータスコードチェック' do
    let!(:exam_date) { ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample) }
    before do
      login Member.create(name: 'some_general_member', access_authority: 2, password: 'some_password')
    end

    xit 'index' do
      get exam_dates_path

      expect(response).to have_http_status(:ok)
    end

    xit 'show' do
      get (exam_date_path id: exam_date.id)

      expect(response).to have_http_status(:ok)
    end

    xit 'search_by_year' do
      get search_by_year_exam_dates_path, { year: exam_date.year }

      expect(response).to have_http_status(:ok)
    end

    xit 'search_by_term' do
      get search_by_term_exam_dates_path, { term: exam_date.term }

      expect(response).to have_http_status(:ok)
    end
  end
end
