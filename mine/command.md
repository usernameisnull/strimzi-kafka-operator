## 环境变量
- source cluster
```asciidoc
cd /root/kafka_2.13-3.6.1
export host='--bootstrap-server 10.6.178.180:9099'
export config='superuser-a.properties'
export topic="topic$(date +%m%d)"
export group="g$(date +%m%d)"
```

- target cluster
```asciidoc
cd /root/kafka_2.13-3.6.1
export host='--bootstrap-server 10.6.178.182:9099'
export config='superuser-b.properties'
export topic="cluster-a.topic$(date +%m%d)"
export group="g$(date +%m%d)"
```

## 命令
- create topic
```asciidoc
bin/kafka-topics.sh --create ${host} --command-config=${config} --topic ${topic}
bin/kafka-topics.sh --create ${host} --command-config=${config} --topic t1
```

- list topic
```asciidoc
bin/kafka-topics.sh --list ${host} --command-config=${config} --exclude-internal
```

- delete topic
```asciidoc
bin/kafka-topics.sh --delete ${host} --command-config=${config} --topic ${topic}
```

- describe topic
```asciidoc
bin/kafka-configs.sh ${host} --entity-type topics --entity-name ${topic} --command-config=${config} --describe --all
```

- producer
```asciidoc
bin/kafka-console-producer.sh ${host} --producer.config ${config} --topic ${topic}
```

- consumer
```asciidoc
bin/kafka-console-consumer.sh ${host} --consumer.config ${config} --topic ${topic}
```

- consume with formatter
```asciidoc
bin/kafka-console-consumer.sh ${host} \
--consumer.config ${config} \
--topic ${topic} \
--formatter org.apache.kafka.connect.mirror.formatters.OffsetSyncFormatter \

```

- consumer group
```asciidoc
bin/kafka-consumer-groups.sh ${host} --consumer.config ${config} --topic ${topic} --group ${group}
```

- list consumer group
```asciidoc
bin/kafka-consumer-groups.sh ${host} --list --command-config ${config}
```

- describe consumer group ##
```asciidoc
bin/kafka-consumer-groups.sh ${host} --describe --group ${group} --command-config ${config}
```

- reset offset
```asciidoc
bin/kafka-consumer-groups.sh ${host} --reset-offsets --to-earliest --execute --group ${group} --topic t2 --command-config ${config}
```

- create group
```asciidoc
bin/kafka-consumer-groups.sh ${host} --create --group ${group} --topic t1
```

- list topic acl
```asciidoc
bin/kafka-acls.sh --bootstrap-server 10.6.178.180:9099  --command-config superuser-b.properties --list --topic cluster-a.topic-0324-01
bin/kafka-acls.sh ${host} --command-config ${config} --list --topic ${topic}
```
