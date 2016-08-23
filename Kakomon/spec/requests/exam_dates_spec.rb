require 'rails_helper'

RSpec.describe "ExamDates", type: :request do
  describe "GET /exam_dates" do
    it "works! (now write some real specs)" do
      get exam_dates_index_path
      expect(response).to have_http_status(200)
    end
  end
end
