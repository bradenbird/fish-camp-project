class User < ActiveRecord::Base
  has_one :chair


  validates :google_uid, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true

  # after_create here to give us chair permission 
  # this will be changed later once we finalize permissons
  # after_create :create_chair, if: ->(user){ user.chair.nil? }

  ADMIN_EMAILS = ["jameslvdb@tamu.edu", "bradenbird@tamu.edu", "jwstone@tamu.edu", "darrelmarek@tamu.edu", "tyler_lamkin@tamu.edu"]

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data['email']).first
    return user unless user.nil?
    user = User.create(name: data['name'],
      google_uid: auth.uid,
      email: data['email'],
      uin: nil,
      role: ADMIN_EMAILS.include?(data['email']) ? 'admin' : 'guest', 
      oauth_token: auth.credentials.token,
      oauth_expires_at: Time.at(auth.credentials.expires_at)
    )
    user.save!
  end


  def create_chair(session_id, color)
    camp_id = Camp.find_by(session_id: session_id, name: color).id
    if chair != nil
      chair.destroy
    end
    create_chair!(camp_id: camp_id)
  end
  
  
  def self.search(search)
    where("name LIKE ? OR uin LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%") 
  end
end
