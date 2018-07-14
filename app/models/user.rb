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
    "admin.email@gmail.com"
  ]

  CHAIR_EMAILS = [
    # Testing email
    "chair.email@gmail.com"
  ]

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data['email']).first
    return user unless user.nil?
    user = User.create(name: data['name'],
      google_uid: auth.uid,
      email: data['email'],
      uin: nil,
      # TODO: figure out better control flow for this 
      role: ADMIN_EMAILS.include?(data['email']) ? 'admin' : 'guest',
      role: CHAIR_EMAILS.include?(data['email']) ? 'chair' : 'guest',
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
