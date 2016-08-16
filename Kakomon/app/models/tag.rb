class Tag < ActiveRecord::Base
  validates :name, :lock, presence: true
  validates :name, length: { maximum: 10 }

  has_many :tag_relations
  has_many :past_questions, through: :tag_relations

end
