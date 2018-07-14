module OmniauthMacros
  def admin_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      'provider' => 'google',
      'uid' => '12345',
      'info' => {
        "email"=>"admin_test_email_string",
        "name"=>"Admin",
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret',
        'expires_at' => Time.now + (60 * 60 * 24)
      }
    })
  end

  def chair_auth_hash
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      'provider' => 'google',
      'uid' => '23456',
      'info' => {
        'email' => "chair_test_email_string",
        'name' => "Chair",
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret',
        'expires_at' => Time.now + (60 * 60 * 24)
      }
    })
  end
end
