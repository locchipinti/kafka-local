FROM cnfldemos/cp-server-connect-datagen:0.5.0-6.2.0

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-s3:10.4.3
