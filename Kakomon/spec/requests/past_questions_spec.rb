require 'rails_helper'

RSpec.describe "PastQuestions", type: :request do
  describe 'ステータスコードテスト' do
    let!(:past_question) do
      login Member.create(name: 'some_super_member', access_authority: 1, password: 'some_password')
      exam_date = ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample)
      PastQuestion.create(
        subject: '教育学', kana: 'きょういくがく', teacher: '小久保弘和',
        file_path: "#{Rails.root}/spec/test.pdf", added_time: Date.today, exam_date_id: exam_date.id,
        views: 0
      )
    end

    it 'index' do
      get past_questions_path
      
      expect(response).to have_http_status(:ok)
    end

    it 'search' do
      get search_past_questions_path, { search_subject: '教育学' }

      expect(response).to have_http_status(:ok)
    end

    it 'sort' do
      get sort_past_questions_path, { q: 'kana' }

      expect(response).to have_http_status(:ok)
    end

    it 'show' do
      get (past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'new' do
      get new_past_question_path

      expect(response).to have_http_status(:ok)
    end

    it 'edit' do
      get (edit_past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'create' do
      post past_questions_path, past_question: past_question.attributes.symbolize_keys
                                                            .except(:id, :created_at, :updated_at, :file_path)
                                                            .merge(
                                                               uploaded_image: fixture_file_upload(
                                                                 File.open(
                                                                   "#{Rails.root}/spec/test.pdf"),
                                                                   'application/pdf', true
                                                                 )
                                                            )

      expect(response).to have_http_status(:see_other)
    end

    it 'update' do
      put (past_question_path id: past_question.id), past_question: { subject: '教育学I' }

      expect(response).to have_http_status(:see_other)
    end

    it 'destroy' do
      delete (past_question_path id: past_question.id)

      expect(response).to have_http_status(:see_other)
    end
  end
end
