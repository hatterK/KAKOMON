class Tag < ActiveRecord::Base
  validates :name, :lock, presence: true
  validates :name, length: { maximum: 10 }

  has_many :tag_relations, dependent: :destroy
  has_many :past_questions, through: :tag_relations

  def index
    @tags = Tag.order("name")
  end

  def show
    @tag = Tag.find(params[:id])
  end

end
