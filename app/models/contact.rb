class Contact < ApplicationRecord
  extend FriendlyId
  friendly_id :last_name, use: :slugged
  validates :first_name, :last_name, :email, :topic, :message, presence: true, allow_blank: false
  #validates, :email, uniqueness: true
  validates :email, confirmation: true
  validates :first_name, :last_name, :topic, format: { with: /\A[a-zA-Z]+\z/,
    message: "only letters" }
  #validates :email, confirmation: { case_sensitive: false }
  #, format: {with: /\A[a-zA-Zo-9 _\.]*\z/}
end
