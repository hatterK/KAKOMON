class ExamDate < ActiveRecord::Base

  has_many :past_questions

  validates :year, :term, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 2010 }


  class << self
    def search(param, val)
      list = self.order()
      if query.present?
        list = list.where("? LIKE ?",
          "%#{param}%", "%#{val}%" )
      end
      list
    end
  end
end
