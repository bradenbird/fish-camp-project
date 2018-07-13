module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
      'provider' => 'ggoogle',
      'uid' => '12345',
      'info' => {
        "email"=>"james@vanderburg.org",
        "name"=>"James Vanderburg"
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret',
        'expires_at' => Time.now + (60 * 60 * 24)
      }
    })
  end
end
