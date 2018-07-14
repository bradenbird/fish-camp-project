class User < ActiveRecord::Base
  has_one :chair, dependent: :destroy

  validates :google_uid, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true

  ADMIN_EMAILS = [
    # Developers
    "jameslvdb@tamu.edu",
    "bradenbird@tamu.edu",
    "jwstone@tamu.edu",
    "darrelmarek@tamu.edu",
    "tyler_lamkin@tamu.edu",
    # Testing email
    "admin_test_email_string"
  ]

  CHAIR_EMAILS = [
    # Testing email
    "chair_test_email_string"
  ]

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data['email']).first
    return user unless user.nil?

    role = ""
    if ADMIN_EMAILS.include?(data['email'])
      role = "admin"
    elsif CHAIR_EMAILS.include?(data['email'])
      role = "chair"
    else
      role = "guest"
    end
    
    user = User.create(name: data['name'],
      google_uid: auth.uid,
      email: data['email'],
      uin: nil,
      role: role,
      oauth_token: auth.credentials.token,
      oauth_expires_at: Time.at(auth.credentials.expires_at)
    )
    user.save!
    return user
  end

  def self.search(search)
    where("name LIKE ? OR uin LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def create_chair(session_id, color)
    camp = Camp.find_by(session_id: session_id, name: color)
    if chair != nil
      chair.destroy
    end
    create_chair!(camp: camp)
  end

  def admin?
    role == 'admin'
  end

  def chair?
    role == 'chair'
  end
end
