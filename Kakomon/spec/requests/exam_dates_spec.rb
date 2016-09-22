require 'rails_helper'

RSpec.describe "ExamDates", type: :request do
  describe 'ステータスコードチェック' do
    let!(:exam_date) { ExamDate.create(year: rand(2011..2015), term: ['first_semester', 'second_semester'].sample) }
    before do
      login Member.create(name: 'some_admin_member', access_authority: 1, password: 'some_password')
    end

    it 'index' do
      get admin_exam_dates_path

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      get (admin_exam_date_path id: exam_date.id)

      expect(response).to have_http_status(:ok)
    end

    it 'new' do
      get new_admin_exam_date_path

      expect(response).to have_http_status(:ok)
    end

    it 'edit' do
      get (edit_admin_exam_date_path id: exam_date.id)

      expect(response).to have_http_status(:ok)
    end

    it 'create' do
      post admin_exam_dates_path, exam_date: exam_date.attributes.symbolize_keys.except(:id, :created_at, :updated_at)

      expect(response).to have_http_status(:see_other)
    end

    it 'update' do
      put (admin_exam_date_path id: exam_date.id), exam_date: { year: '2025' }

      expect(response).to have_http_status(:see_other)
    end

    it 'destroy' do
      delete (admin_exam_date_path id: exam_date.id)

      expect(response).to have_http_status(:see_other)
    end

    it 'search' do
      get search_admin_exam_dates_path, { search_year: exam_date.year, search_term: exam_date.term }

      expect(response).to have_http_status(:ok)
    end
  end
end
