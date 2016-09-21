require 'rails_helper'

RSpec.describe "PastQuestions", type: :request do
  describe 'ステータスコードテスト' do
    let!(:past_question) do
      login Member.create(name: 'some_editor_member', access_authority: 2, password: 'some_password')
      exam_date = ExamDate.create(year: rand(2011..2015), term: ['前期', '後期'].sample)
      create(:past_question, exam_date_id: exam_date.id)
    end

    it 'editor_index' do
      get editor_past_questions_path

      expect(response).to have_http_status(:ok)
    end

    it 'editor_search' do
      get search_editor_past_questions_path, { search_subject: '教育学', sort_method: 'subject' }

      expect(response).to have_http_status(:ok)
    end

    it 'editor_show' do
      get (editor_past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'editor_new' do
      get new_editor_past_question_path

      expect(response).to have_http_status(:ok)
    end

    it 'editor_edit' do
      get (edit_editor_past_question_path id: past_question.id)

      expect(response).to have_http_status(:ok)
    end

    it 'editor_create' do
      post editor_past_questions_path, past_question: past_question.attributes.symbolize_keys
                                                            .except(:id, :created_at, :updated_at, :image, :views)
                                                            .merge(
                                                               image: fixture_file_upload(
                                                                 "/pdf/test.pdf", 'application/pdf', true),
                                                               year: 2016, term: 'first_semester'
                                                            )

      expect(response).to have_http_status(:see_other)
    end

    it 'editor_update' do
      put (editor_past_question_path id: past_question.id), past_question: { subject: '教育学I' }

      expect(response).to have_http_status(:see_other)
    end
  end
end
