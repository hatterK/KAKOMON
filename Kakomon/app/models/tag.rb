class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 10 }

  has_many :tag_relations, dependent: :destroy
  has_many :past_questions, through: :tag_relations

  

end
