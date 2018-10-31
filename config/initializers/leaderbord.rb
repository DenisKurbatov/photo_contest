require 'leaderboard'
uri = ENV['REDISTOGO_URL'] || 'redis://localhost:6379/'
REDIS = Redis.new(url: uri)
redis_options = { redis_connection: REDIS }

PastState = Leaderboard.new('paststate', Leaderboard::DEFAULT_OPTIONS, redis_options)
