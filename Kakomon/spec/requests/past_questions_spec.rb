require 'rails_helper'

RSpec.describe "PastQuestions", type: :request do
  describe "GET /past_questions" do
    it "works! (now write some real specs)" do
      get past_questions_index_path
      expect(response).to have_http_status(200)
    end
  end
end
