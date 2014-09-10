require File.expand_path(File.dirname(__FILE__) + '/config')

(queue_name, topicARN) = ARGV
unless queue_name && topicARN
  puts "Usage: create_queue <queue name> <topic arn>"
  exit 1
end

sqsClient = AWS::SQS::Client::new

queueURL = sqsClient.create_queue({:queue_name => queue_name})[:queue_url];
puts "queue url is #{queueURL}"

sqs = AWS::SQS::new

queue = sqs.queues[queueURL]
puts "queue ARN is #{queue.arn}"

policyJson = '{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"SQSPolicy",
      "Effect":"Allow",
      "Principal":"*",
      "Action":"sqs:SendMessage",
      "Resource":"' + queue.arn + '",
      "Condition":{
        "ArnEquals":{
          "aws:SourceArn":"' + topicARN + '"
        }
      }
    }
  ]
}'

policy = AWS::SQS::Policy.from_json(policyJson)

queue.policy = policy
