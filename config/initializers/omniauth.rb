# EnforcedStyle: with_first_parameter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, ENV['API_KEY'], ENV['API_SECRET'], scope: 'email',
                                                          display: 'popup',
                                                          https: 1,
                                                          lang: 'ru'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user,public_repo'
end
