class User
  include Mongoid::Document

  attr_accessor :password, :password_confirmation

  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :password_salt,      type: String, default: ""

  field :active,             type: Boolean, default: false
  field :confirmation_token, type: String
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time


  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String


  after_create :send_activation_email

  validates_uniqueness_of :email, :message => "Email provided is already in use"
  validates_length_of :password, minimum: 8, maximum: 16

  def self.authenticate(email, password)
    user = find_by_email(email)
    user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt) ? user: nil
  end

  private
  def send_activation_email

  end
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(self.password, password_salt)
    end
  end
end
