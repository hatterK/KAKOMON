class Tag < ActiveRecord::Base
  validates :name, presence: true
  validates :name, length: { maximum: 10 }

  has_many :tag_relations, dependent: :destroy
  has_many :past_questions, through: :tag_relations

  class << self
    def get_tag(name)
      if self.exists?(name: name)
        tag = self.find_by(name: name)
        tag
      else
        tag = self.new(name: name, lock: false)
        if tag.save
          tag
        else
          nil
        end
      end
    end

  end

end
