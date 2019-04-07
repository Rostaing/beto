class Post < ApplicationRecord
  acts_as_votable
  #belongs_to :user
  belongs_to :category 
  has_many :comments
  validates :title, :author, :image, :description, presence: true, allow_blank: false
  validates_length_of :author, :maximum => 30
  validates :title, :author, format: { with: /\A[a-zA-Z]+\z/,
    message: "only letters" }
  mount_uploader :image, ImageUploader

  extend FriendlyId
  friendly_id :title, use: :slugged

  def display_day_published
		"Published #{created_at.strftime('%-b %-d, %Y')}"
  end
end
