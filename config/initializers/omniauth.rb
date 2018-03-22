# Do not use keys in plain text on GitHub

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	#! ! ! CHANGE ! ! !
	provider :google_oauth2, '506434569924-4ago21nj9cjdd6t1vjco41lbch8daqbn.apps.googleusercontent.com', 'ONLPQqgdxODQlkDy_k2mRNZU', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}, skip_jwt: true}
end