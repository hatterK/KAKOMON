class Member < ActiveRecord::Base

  validates :name, presence: true,
    format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true },
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }
  validates :password, presence: { on: create },
    confirmation: { allow_blank: true }
  validates :access_authority, presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }


  attr_accessor :password, :password_confirmation

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  class << self
    def authenticate( name, password )
      member = find_by(name: name)
      if member && member.hashed_password.present? && BCrypt::Password.new(member.hashed_password) == password
        member
      else
        nil
      end
    end
  end

end
