require File.expand_path(File.dirname(__FILE__) + '/config')

(topic_arn, dummy) = ARGV
unless topic_arn
  puts "Usage: publish_to_topic <topic arb>"
  exit 1
end

snsClient = AWS::SNS::Client::new

msgId = snsClient.publish({
  :topic_arn => topic_arn,
  :message => 'A message for you',
  :subject => 'XTRAC alert'
})[:message_id]

puts "published message #{msgId}"
