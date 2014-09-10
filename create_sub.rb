require File.expand_path(File.dirname(__FILE__) + '/config')

(topic_arn, queue_arn) = ARGV
unless topic_arn && queue_arn
  puts "Usage: create_sub <topic arb> <queue arn>"
  exit 1
end

snsClient = AWS::SNS::Client::new

subARN = snsClient.subscribe({
  :topic_arn => topic_arn,
  :protocol => 'sqs',
  :endpoint => queue_arn
})[:subscription_arn];

puts "subscription arn is #{subARN}"
