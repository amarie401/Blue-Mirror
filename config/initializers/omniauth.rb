OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV.fetch('GOOGLE_CLIENT_ID'),
           ENV.fetch('GOOGLE_CLIENT_SECRET'),
           client_options: {
             ssl: { ca_file: Rails.root.join('cacert.pem').to_s }
           },
           name: 'google',
           scope: 'email, profile'

  provider :facebook, ENV.fetch('FACEBOOK_APP_ID'),
           ENV.fetch('FACEBOOK_APP_SECRET')
end
