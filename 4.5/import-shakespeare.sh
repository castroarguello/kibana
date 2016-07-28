#!/bin/bash

FILE="/shakespeare.json"
if [ ! -f $FILE ];
then
  wget https://www.elastic.co/guide/en/kibana/3.0/snippets/shakespeare.json
fi

curl -XPOST "http://localhost:5601/elasticsearch/.kibana/index-pattern/shakespeare?op_type=create" -d '{"title":"shakespeare"}'  -H "kbn-version: 4.5.3"
curl -XPOST "http://localhost:5601/elasticsearch/.kibana/config/4.5.3/_update" -d '{"doc":{"buildNum":9910,"defaultIndex":"shakespeare"}}'  -H "kbn-version: 4.5.3"
curl -XPUT http://elasticsearch:9200/shakespeare -d '
{
 "mappings" : {
  "_default_" : {
   "properties" : {
    "speaker" : {"type": "string", "index" : "not_analyzed" },
    "play_name" : {"type": "string", "index" : "not_analyzed" },
    "line_id" : { "type" : "integer" },
    "speech_number" : { "type" : "integer" }
   }
  }
 }
}
';
curl -XPUT elasticsearch:9200/_bulk --data-binary "@shakespeare.json" -s
echo "IMPORT FINISHED"
