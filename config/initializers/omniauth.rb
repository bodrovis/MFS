Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'Bp5EKaJ4PSlaquO6GJDGWA', 'gu9ZVpYlTVcgy0SkS0I44w83v5NHfwKCzlZnEyCYc',
           image_size: 'original'
end