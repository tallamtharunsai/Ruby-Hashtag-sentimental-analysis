require 'twitter'
require 'sentimental'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "F2A14NAvxJI4lvamiTypD9Bq3"
  config.consumer_secret     = "6CEAtbVEfUlhUn2tgFF3SU3zGd4Rlq3hUGhiYPaOY13OeDlvmH"
  config.access_token        = "2911633458-AkBXiyRB3dZtpviDICHdNbjwVctvTZA5z25zQLf"
  config.access_token_secret = "EMdQhZ4VRzkv5WOlsawIcsprLVkl0q6cy7USrzq55aUaJ"
end
tweets = []
client.search('#PLANTS').take(50).each do |tweet|
  tweets.push(tweet.text)
end

analyzer = Sentimental.new
analyzer.load_defaults

def sent(a)
  ana = Sentimental.new
  ana.load_defaults
  avscore=0
  for i in 0..a.length
    score = ana.score(a[i])
    avscore+=score
  end
  return avscore/a.length
end
avg_sen = 0
neg_tweets=[]
pos_tweets=[]
for i in 0..tweets.length
  score=analyzer.score(tweets[i])
  avg_sen+=score
  if score>=0
    pos_tweets.push(tweets[i])
  else
    neg_tweets.push(tweets[i])
  end
end
puts "Match Sentiment is "
s=avg_sen/tweets.length
puts s
puts "----------------------------------------"
if s<0
    puts"ITS a negative Sentiment"
else
    puts"Its a Positive sentiment"
end
