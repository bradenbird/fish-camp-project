class User < ActiveRecord::Base
  has_one :chairs

  validates :google_uid, presence: true
  validates :name, presence: true
  validates :email, presence: true
  validates :role, presence: true

  def self.from_omniauth(auth)
    data = auth.info
    user = User.where(email: data['email']).first
    unless user 
      user = User.create(name: data['name'],
        google_uid: auth.uid,
        email: data['email'],
        uin: nil,
        role: 'guest',
        oauth_token: auth.credentials.token,
        oauth_expires_at: Time.at(auth.credentials.expires_at)
      )
      user.save!
    end
    user
    #where(google_uid: auth.uid).first_or_initialize.tap do |user|
    #  user.google_uid = auth.uid
    #  user.name = auth.info.name
    #  user.email = auth.info.email
    #  user.uin = nil #Fill in later
    #  user.role = 'admin'
    #  user.oauth_token = auth.credentials.token
    #  user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    #  user.save!
    #end
  end
end
