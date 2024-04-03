#!/bin/bash
cd /root/kafka_2.13-3.1.0
user=superuser-b
cluster=cluster-b
kubectl get secret ${cluster}-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 -d > ${cluster}-ca.crt
kubectl get secret ${user} -o jsonpath='{.data.user\.password}' | base64 -d > ${user}.password
kubectl get secret ${user} -o jsonpath='{.data.user\.p12}' | base64 -d > ${user}.p12

password=$(cat ${user}.password)
cat <<EOF > ${user}.properties
security.protocol=SSL
ssl.truststore.location=${user}-truststore.jks
ssl.truststore.password=${password}
ssl.keystore.location=${user}-keystore.jks
ssl.keystore.password=${password}
ssl.key.password=${password}
EOF

# cat superuser.password
# keytool -alias CARoot -import -keystore ${user}-truststore.jks -file ${cluster}-ca.crt
# keytool -importkeystore  -srcstoretype pkcs12  -deststoretype jks -destkeystore ${user}-keystore.jks -srckeystore ${user}.p12


