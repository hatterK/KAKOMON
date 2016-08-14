class PastQuestion < ActiveRecord::Base
  validates :subject, :year, :term, :file_path, :data_type, :added_time, presence: true
  validates :subject, length: { maximum: 100 }
  validates :kana, length: { maximum: 100 }
  validates :teacher, length: { maximum: 20 }
  validates :file_path, lenth: { maximum: 100 }
  validate :check_file_path

  belongs_to :exam_date

  private
  def check_file_path
    data_type = File.extname("#{file_path}")
    valid = (data_type =~ /[jJ][pP][gG]\z/) || (data_type =~ /[pP][nN][gG]\z/) || (data_type =~ /[pP][dD][fF]\z/)
    errors.add(:file_path, :invalid) unless valid && File.exist?("#{file_path}")
  end
end
