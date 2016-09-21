require 'rails_helper'

RSpec.describe "PastQuestions", type: :request do
  describe 'ステータスコードテスト' do
    let!(:past_question) do
      login Member.create(name: 'some_admin_member', access_authority: 1, password: 'some_password')
      exam_date = ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample)
      create(:past_question, exam_date_id: exam_date.id)
    end

    it 'admin_index' do
      get admin_past_questions_path

      expect(response).to have_http_status(:ok)
    end

    it 'admin_search' do
      get search_admin_past_questions_path, { search_subject: '教育学', sort_method: 'year' }

      expect(response).to have_http_status(:ok)
    end

    it 'admin_show' do
      get (admin_past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'admin_new' do
      get new_admin_past_question_path

      expect(response).to have_http_status(:ok)
    end

    it 'admin_edit' do
      get (edit_admin_past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'admin_create' do
      post admin_past_questions_path, past_question: past_question.attributes.symbolize_keys
                                                            .except(:id, :created_at, :updated_at, :image, :views)
                                                            .merge(
                                                               image: fixture_file_upload(
                                                                 "/img/sample.jpg", 'image/jpg'
                                                               ),
                                                               year: 2016, term: 'first_semester'
                                                            )

      expect(response).to have_http_status(:see_other)
    end

    it 'admin_update' do
      put (admin_past_question_path id: past_question.id), past_question: { subject: '教育学I' }

      expect(response).to have_http_status(:see_other)
    end

    it 'admin_destroy' do
      delete (admin_past_question_path id: past_question.id)

      expect(response).to have_http_status(:see_other)
    end
  end
end
