class ExamDate < ActiveRecord::Base
  validates :year, :term, presence: true
  validates :year, numericality: { only_integer: true, greater_than: 2010 }

  has_many :past_questions

end
