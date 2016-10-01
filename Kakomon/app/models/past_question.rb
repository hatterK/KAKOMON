class PastQuestion < ActiveRecord::Base
  belongs_to :exam_date
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations

  validates :subject, presence: true
  validates :subject, length: { maximum: 100 }
  validates :kana, length: { maximum: 100 }
  validates :teacher, length: { maximum: 20 }
  validates :image, presence: { on: create }
  validates :pub, presence: { on: create }
  validate :check_image
  validate :check_file_path


  attr_accessor :tag_name, :year, :term
  attr_accessor :search_subject, :search_teacher, :search_year, :search_term,
    :search_tag1, :search_tag2, :search_tag3, :sort_method

  mount_uploader :image, ImageUploader

  private

  def check_image
    errors.add(:image, 'too_big_image') if image && image.size > 3.megabytes
  end

  def check_file_path
    if image && image.current_path
      errors.add(:image, 'image_not_exist') unless File.exist?(image.current_path)
    else
      errors.add(:image, 'image_not_exist')
    end
  end

  class << self
    def search(query)
      list = self.where(
        "subject LIKE ? OR kana LIKE ?",
        "%#{query[:search_subject]}%",
        "%#{query[:search_subject]}%"
      ).where("teacher LIKE ?", "%#{query[:search_teacher]}%")
      if query[:search_year].present? || query[:search_term].present?
        list = list.joins(:exam_date)
        list = list.where("exam_dates.year = ?", query[:search_year]) if query[:search_year].present?
        list = list.where("exam_dates.term LIKE ?","%#{query[:search_term]}%")
      end
      if query[:search_tag1].present? || query[:search_tag2].present? || query[:search_tag3].present?
        list = list.joins(:tags)
        list = list.where("tags.name LIKE ?", "%#{query[:search_tag1]}%")
          .where("tags.name LIKE ?", "%#{query[:search_tag2]}%")
          .where("tags.name LIKE ?", "%#{query[:search_tag3]}%")
      end
      list = list.uniq
      list
    end

    def sort_by(sort_method)
      case sort_method
      when 'year_desc' then joins(:exam_date).order('exam_dates.year DESC')
      when 'year_asce' then joins(:exam_date).order('exam_dates.year')
      when 'views' then order(views: :desc)
      when 'subject' then order(:subject)
      when 'teacher' then order(:teacher)
      else order(created_at: :desc)
      end
    end
  end
end
