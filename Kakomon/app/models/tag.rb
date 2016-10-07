class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 20 }

  has_many :tag_relations, dependent: :destroy
  has_many :past_questions, through: :tag_relations

  class << self
    def get_tag(name)
      if exists?(name: name)
        find_by(name: name)
      else
        tag = new(name: name, lock: false)
        return nil unless tag.save
        tag
      end
    end
  end
end
