# EnforcedStyle: with_first_parameter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '6640136', 'yrTIZ5zzKSPXoO8EMIGg', scope: 'email',
                                                          display: 'popup',
                                                          https: 1,
                                                          lang: 'ru'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: 'user,public_repo'
end
