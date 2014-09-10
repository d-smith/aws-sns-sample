require File.expand_path(File.dirname(__FILE__) + '/config')

snsClient = AWS::SNS::Client::new
topicARN = snsClient.create_topic({:name => "foo"})[:topic_arn]
puts "topic ARN is #{topicARN}"
