# Do not use keys in plain text on GitHub

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	#! ! ! CHANGE ! ! !
	provider :google_oauth2, ENV['GOOGLE_CLIENT'], ENV['GOOGLE_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, skip_jwt: true}
end
