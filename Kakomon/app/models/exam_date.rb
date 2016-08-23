class ExamDate < ActiveRecord::Base

  has_many :past_questions

  validates :year, :term, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 2010 }


  class << self
    def get_exam_date(exam_params)
      if self.exists?(exam_params)
        exam_date = self.find_by(exam_params)
        exam_date
      else
        exam_date = self.new(exam_params)
        if exam_date.save
          exam_date
        else
          nil
        end
      end
    end

    def search(year_q, term_q)
      if year_q.present? || term_q.present?
        list = self.order(:id)
        if year_q.present?
          list = list.where("year LIKE ?","%#{year_q}%" )
        end
        if term_q.present?
          list = list.where("term LIKE ?", "%#{term_q}%")
        end
        list
      else
        nil
      end
    end
  end
end
