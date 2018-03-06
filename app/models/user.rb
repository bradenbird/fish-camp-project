class User < ActiveRecord::Base
  has_one :chairs

  def self.from_omniauth(auth)
    where(google_uid: auth.uid).first_or_initialize.tap do |user|
      user.google_uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.uin = nil #Fill in later
      user.role = 'admin'
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
