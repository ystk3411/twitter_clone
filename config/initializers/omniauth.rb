Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [:post, :get]
  OmniAuth.config.full_host = 'https://twitterclone202404-a203c730342a.herokuapp.com' if Rails.env.production?
end