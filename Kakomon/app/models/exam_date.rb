class ExamDate < ActiveRecord::Base
  has_many :past_questions

  validates :year, :term, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 2010 }

  class << self
    def get_exam_date(exam_params)
      if exists?(exam_params)
        find_by(exam_params)
      else
        exam_date = new(exam_params)
        if exam_date.save
          exam_date
        end
      end
    end

    def search(year_q, term_q)
      if year_q.present? || term_q.present?
        list = order(:id)
        list.where('year LIKE ?', "%#{year_q}%").where('term LIKE ?', "%#{term_q}%")
      end
    end
  end
end
