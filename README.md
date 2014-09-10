Scripts to create a topic, create a queue granting send message permissions to the
topic, subscribe the queue to the topic, and finally publish to the
topic.

In the directory above the one containing these scripts, create a
config.yml file to contain the IAM access key id and secret access key
you intend to use when running the scripts. Note you will need the
appropriate access policies associated with your IAM user as described below.

        vagrant@precise64:/vagrant/dev/aws-ruby-samples$ cat ../config.yml
        access_key_id: akeyid
        secret_access_key: asecretaccesskey

To run the scripts, I created a new custom policy and associated it with the group
of the identity used to run the script:


      {
         "Version":"2012-10-17",
         "Statement":[{
            "Effect":"Allow",
            "Action":["sns:CreateTopic","sns:DeleteTopic","sns:Subscribe","sns:Publish"],
            "Resource":"*"
            }
         ]
      }

To create the topic:

    vagrant@precise64:/vagrant/dev/aws-sns$ ruby create_topic.rb testQueueTopic
    topic ARN is arn:aws:sns:us-east-1:930295567417:testQueueTopic

To create the queue:

    vagrant@precise64:/vagrant/dev/aws-sns$ ruby create_queue.rb testQueue arn:aws:sns:us-east-1:930295567417:testQueueTopic
    queue url is https://sqs.us-east-1.amazonaws.com/930295567417/testQueue
    queue ARN is arn:aws:sqs:us-east-1:930295567417:testQueue

To create the subscription:

    vagrant@precise64:/vagrant/dev/aws-sns$ ruby create_sub.rb arn:aws:sns:us-east-1:930295567417:testQueueTopic arn:aws:sqs:us-east-1:930295567417:testQueue
    subscription arn is arn:aws:sns:us-east-1:930295567417:testQueueTopic:6b94128a-5a82-4a8d-b8a8-b2fbb28a158d

Finally, to publish a message to the topic:

    vagrant@precise64:/vagrant/dev/aws-sns$ ruby publish_to_topic.rb arn:aws:sns:us-east-1:930295567417:testQueueTopic
    published message 41d7b69b-c41d-55bb-a646-fa11072ff705
