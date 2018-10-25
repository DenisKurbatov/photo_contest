# EnforcedStyle: with_first_parameter
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '6640136', 'yrTIZ5zzKSPXoO8EMIGg', scope: 'email',
                                                          display: 'popup',
                                                          https: 1,
                                                          lang: 'ru'
  provider :github, "2fc99c57abf3f5dacec1", "6ec9f34ed00f99c5e3b050f1e9010bdd7bcfb510", scope: 'user,public_repo'
end
