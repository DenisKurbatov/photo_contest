require 'leaderboard'
uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:url => uri)
redis_options = {:redis_connection => REDIS}
LikesRating = Leaderboard.new('highscores')
PastState = Leaderboard.new('paststate', Leaderboard::DEFAULT_OPTIONS, redis_options)
