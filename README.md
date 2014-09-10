Scripts to create a topic, subscribe to a topic, and publish to an
SNS topic.

To create a topic, I created a new custom policy and associated it with the group
of the identity used to run the script:


      {
         "Version":"2012-10-17",
         "Statement":[{
            "Effect":"Allow",
            "Action":["sns:CreateTopic","sns:DeleteTopic"],
            "Resource":"*"
            }
         ]
      }
