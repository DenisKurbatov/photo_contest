require 'leaderboard'
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => uri)
redis_options = {:redis_connection => REDIS}

PastState = Leaderboard.new('paststate', redis_options)
