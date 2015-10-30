class User < ActiveRecord::Base
  has_secure_password
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "50x50#"}
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  has_many :events
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: EMAIL_REGEX }
  validates :email, :uniqueness => { :case_sensitive => false }
end
