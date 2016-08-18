class PastQuestion < ActiveRecord::Base

  belongs_to :exam_date
  has_many :tag_relations, dependent: :destroy
  has_many :tags, through: :tag_relations

  validates :subject, presence: true
  validates :subject, length: { maximum: 100 }
  validates :kana, length: { maximum: 100 }
  validates :teacher, length: { maximum: 20 }
  validates :file_path, presence: true
  validates :file_path, length: { maximum: 100 }
  validate :check_file_path
  validates :added_time, presence: true
  # validates :year, :term, presence: { on: :create }
  # validates :year, numericality: { greater_than: 2000, less_than: 3000, allow_blank: true }
  # validates :term, length: { maximum: 20 }
  # validates :tag_name, length: { maximum: 10 }

  attr_accessor :tag_name, :year, :term
  # mount_uploader :file_path, PastQuestion

  private
  def check_file_path
    content_type = File.extname("#{file_path}")
    path = Rails.root.join("app/assets/images", file_path)
    errors.add(:file_path, :invalid) unless (content_type =~ /[jJ][pP].?[gG]\z|[pP][nN][gG]\z|[pP][dD][fF]\z/)
    # errors.add(:file_path, :file_not_exist) unless File.exists?(path)
  end

  class << self
    def search(query)
      list = self.order(added_time: :desc)
      if query.present?
        list = list.where("subject LIKE ? OR kana LIKE ?",
          "%#{query}%", "%#{query}%" )
      end
      list
    end

    def sort_by(param, is_desc = true)
      if is_desc
        list = self.reverse_order(param)
      else
        list = self.order(param)
      end
      list
    end
  end
end
