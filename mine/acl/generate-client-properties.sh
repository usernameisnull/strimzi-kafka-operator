#!/bin/bash
cd /root/kafka_2.13-3.1.0
user=superuser-a
cluster=cluster-a
kubectl get secret ${cluster}-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 -d > ${cluster}-ca.crt
kubectl get secret ${user} -o jsonpath='{.data.user\.password}' | base64 -d > ${user}.password
kubectl get secret ${user} -o jsonpath='{.data.user\.p12}' | base64 -d > ${user}.p12

# cat superuser.password
# keytool  -alias CARoot -import -keystore ${user}-truststore.jks -file ${cluster}-ca.crt
# keytool -importkeystore  -srcstoretype pkcs12  -deststoretype jks -destkeystore ${user}-keystore.jks -srckeystore ${user}.p12


# cat client-b.properties
# security.protocol=SSL
# ssl.truststore.location=user-b-truststore.jks
# ssl.truststore.password=f26hVp2U6OoOsXKxfEc2YRe1tXssvWWj
# ssl.keystore.location=user-b-keystore.jks
# ssl.keystore.password=f26hVp2U6OoOsXKxfEc2YRe1tXssvWWj
# ssl.key.password=f26hVp2U6OoOsXKxfEc2YRe1tXssvWWj


# export host='--bootstrap-server 10.6.178.180:9099'
# export config='superuser-b.properties'
# export topic='cluster-a.topic-0322'

# list topic
# bin/kafka-topics.sh --list ${host} --command-config=${config} --exclude-internal

# producer
# bin/kafka-console-producer.sh ${host} --producer.config ${config} --topic ${topic}
# bin/kafka-console-producer.sh --bootstrap-server 10.6.178.182:9099 --producer.config  superuser-a.properties --topic topic-0322

# consumer
# bin/kafka-console-consumer.sh ${host} --consumer.config ${config} --topic ${topic}
# bin/kafka-console-consumer.sh --bootstrap-server 10.6.178.180:9099 --consumer.config  superuser-b.properties --topic cluster-a.topic-0322 --from-beginning

# list topic acl
bin/kafka-acls.sh ${host}  --command-config ${config} --list --topic ${topic}

