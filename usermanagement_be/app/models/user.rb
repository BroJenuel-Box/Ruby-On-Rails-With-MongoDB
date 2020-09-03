class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :username, type: String
  field :email, type: String
  field :password_digest, type: String
  field :type, type: Integer
  field :token, type: String

  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, :length => { :minimum => 9 },  :on => :create

  has_secure_password
end
