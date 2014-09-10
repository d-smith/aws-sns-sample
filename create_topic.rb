require File.expand_path(File.dirname(__FILE__) + '/config')

(topicName, dummy) = ARGV
unless topicName
  puts "Usage: create_topic <topic name>"
  exit 1
end

snsClient = AWS::SNS::Client::new
topicARN = snsClient.create_topic({:name => topicName})[:topic_arn]
puts "topic ARN is #{topicARN}"
