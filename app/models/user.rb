class User < ApplicationRecord
  #include Chat::User
  # attr_accessor: login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #username field
  # validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Zo-9 _\.]*\z/}
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  #devise :omniauthable, omniautn_providers: [:facebook]

  acts_as_voter
         
  has_many :comments, dependent: :destroy
  # has_many :posts

   def uname
   	return username
   end

   attr_writer :login

    def login
      @login || self.username || self.email
    end

    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end

    validate :validate_username

    def validate_username
      if User.where(email: username).exists?
        errors.add(:username, :invalid)
      end
    end
end
