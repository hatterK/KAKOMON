require 'rails_helper'

RSpec.describe "PastQuestions", type: :request do
  describe 'ステータスコードテスト' do
    let!(:past_question) do
      login Member.create(name: 'some_user_member', access_authority: 3, password: 'some_password')
      exam_date = ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample)
      create(:past_question, exam_date_id: exam_date.id)
    end

    it 'index' do
      get past_questions_path

      expect(response).to have_http_status(:ok)
    end

    it 'search' do
      get search_past_questions_path, { search_subject: '教育学', sort_method: 'views' }

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      get (past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end
  end
end
