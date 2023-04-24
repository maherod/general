#!/usr/bin/env python3
import time
from elasticsearch import Elasticsearch
from prometheus_client import start_http_server, Gauge

# Update these variables with your Elasticsearch host and port
ES_HOST = 'elasticsearch'
ES_PORT = 9200

# Prometheus metrics
INDEX_SIZE_GAUGE = Gauge('elasticsearch_index_size_bytes', 'Size of the index in bytes', ['index_name'])
SHARD_COUNT_GAUGE = Gauge('elasticsearch_index_shard_count', 'Number of shards in the index', ['index_name'])
REPLICA_COUNT_GAUGE = Gauge('elasticsearch_index_replica_count', 'Number of replicas in the index', ['index_name'])

def connect_to_elasticsearch():
    return Elasticsearch([{'scheme': 'http', 'host': ES_HOST, 'port': ES_PORT}])

def list_indices(es):
    return es.cat.indices(format='json')

def get_index_stats(es, index_name):
    return es.indices.stats(index=index_name)

def update_metrics(indices, es):
    for index in indices:
        index_name = index['index']
        index_stats = get_index_stats(es, index_name)
        index_info = index_stats['_all']['primaries']
        index_settings = es.indices.get_settings(index=index_name)[index_name]['settings']['index']

        INDEX_SIZE_GAUGE.labels(index_name=index_name).set(index_info['store']['size_in_bytes'])
        SHARD_COUNT_GAUGE.labels(index_name=index_name).set(index_settings['number_of_shards'])
        REPLICA_COUNT_GAUGE.labels(index_name=index_name).set(index_settings['number_of_replicas'])

if __name__ == '__main__':
    start_http_server(8000)
    es = connect_to_elasticsearch()

    while True:
        indices = list_indices(es)
        update_metrics(indices, es)
        time.sleep(60)  # Update metrics every minute