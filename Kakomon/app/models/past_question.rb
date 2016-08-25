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
  validates :added_time, presence: true
  validate :check_image
  validate :check_file_path

  attr_accessor :tag_name, :year, :term
  attr_accessor :search_subject, :search_teacher, :search_year, :search_term,
    :search_tag1, :search_tag2, :search_tag3, :sort_method
  attr_reader :uploaded_image
  # IMAGE_TYPES = ["jpg", "png", "pdf"]
  # mount_uploader :file_path, PastQuestion

  def uploaded_image=(image)
    @extension = convert_content_type(image.content_type)
    @data = image.read
    file_name = File.basename(image.original_filename, '.*')
    path_p = Rails.root.join('app/assets/images', @extension)
    path = path_p + "#{file_name}.#{@extension}"

    if FileTest.exists?(path)
      num = 0
      begin
        num += 1
        path = path_p + "#{file_name}#{num}.#{@extension}"
      end while FileTest.exists?(path)
    end

    open(path, 'wb') do |output|
      output.write(@data)
    end
    self.file_path = "#{@extension}/" + File.basename(path)
    @uploaded_image = image
  end

  private

  def convert_content_type(ctype)
    ctype = ctype.rstrip.downcase
    case ctype
    when 'image/pjepg' then 'jpg'
    when 'image/jpg' then 'jpg'
    when 'image/x-png' then 'png'
    when 'image/jpeg' then 'jpg'
    when 'image/png' then 'png'
    when %r{.*application/pdf.*} then 'pdf'
    end
  end

  def check_image
    errors.add(:uploaded_image, 'too_big_image') if @uploaded_image && @data.size > 3.megabytes
  end

  def check_file_path
    if file_path
      content_type = File.extname(file_path)
      path = Rails.root.join('app/assets/images', file_path)
      validness = content_type =~ /[jJ][pP].?[gG]\z|[pP][nN][gG]\z|[pP][dD][fF]\z/
      errors.add(:file_path, 'invalid_image') unless validness
      errors.add(:file_path, 'file_not_exist') unless File.exist?(path)
    else
      errors.add(:file_path, 'file_not_exist')
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
        if query[:search_year].present?
          list = list.where("exam_dates.year = ?", query[:search_year])
        end
        list = list.where("exam_dates.term LIKE ?","%#{query[:search_term]}%")
      end
      if query[:search_tag1].present? || query[:search_tag2].present? || query[:search_tag3].present?
        list = list.joins(:tags)
        list = list.where("tags.name LIKE ?", "%#{query[:search_tag1]}%")
          .where("tags.name LIKE ?", "%#{query[:search_tag2]}%")
          .where("tags.name LIKE ?", "%#{query[:search_tag3]}%")
      end
      list = list.uniq
      # list = list.order('exam_dates.year DESC')
      list
    end

    def sort_by(sort_method)
      case sort_method
      when 'year_desc' then order('exam_dates.year DESC')
      when 'year_asce' then order('exam_dates.year')
      when 'views' then order(views: :desc)
      when 'subject' then order(:subject)
      when 'teacher' then order(:teacher)
      else order(created_at: :desc)
      end
    end
  end
end
