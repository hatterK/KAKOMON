class TagRelation < ActiveRecord::Base

  belongs_to :past_question
  belongs_to :tag

  validates :past_question_id, presence: true
  validates :tag_id, presence: true
end
