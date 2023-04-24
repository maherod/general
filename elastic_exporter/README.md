# Elasticsearch Exporter for Prometheus

This exporter collects Elasticsearch index metrics, such as index size, shard count, and replica count, and exposes them for Prometheus to scrape. The exporter is implemented using Python and requires the `elasticsearch` and `prometheus_client` packages.

## Metrics

The exporter collects the following metrics:

- `elasticsearch_index_size_bytes`: Size of the index in bytes, labeled by index name.
- `elasticsearch_index_shard_count`: Number of shards in the index, labeled by index name.
- `elasticsearch_index_replica_count`: Number of replicas in the index, labeled by index name.

## Requirements

- Python 3.6 or later
- Elasticsearch Python package
- Prometheus Client Python package

You can install the required packages using the following command:

```bash
pip install elasticsearch prometheus_client
```

## Usage

1. Update the `ES_HOST` and `ES_PORT` variables in the `es_exporter.py` script with your Elasticsearch host and port.

2. Run the exporter script:

```bash
python es_exporter.py
```

The exporter will start an HTTP server on port 8000 and expose the metrics at `http://localhost:8000/metrics`.

3. Configure your Prometheus server to scrape the metrics from the exporter by updating the `prometheus.yml` configuration file:

```
scrape_configs:
  - job_name: 'elasticsearch_exporter'
    scrape_interval: 1m
    static_configs:
      - targets: ['<exporter_host>:8000']
```

Replace `<exporter_host>` with the hostname or IP address where the exporter is running.

4. Restart the Prometheus server to apply the changes.

5. Create a Grafana dashboard to visualize the collected metrics. You can use the provided PromQL queries, such as `elasticsearch_index_size_bytes{job="elasticsearch_exporter"}`, to display the index size, shard count, and replica count.

## Docker

To run the exporter in a Docker container, use the provided `Dockerfile` and `requirements.txt` files. Build the Docker image using the following command:

```bash
docker build -t es_exporter .
```

Then, run the exporter in a Docker container:

```bash
docker run -d --name es_exporter -p 8000:8000 -e ES_HOST=<elasticsearch_host> -e ES_PORT=<elasticsearch_port> es_exporter
```

Replace `<elasticsearch_host>` and `<elasticsearch_port>` with the appropriate values for your Elasticsearch instance.

## License

This project is licensed under the [MIT License](LICENSE).
```

Save this content as `README.md` in the same directory as the exporter script, `Dockerfile`, and `requirements.txt`. This README file will provide a comprehensive explanation of the exporter, its metrics, requirements, and usage instructions for both standalone and Docker deployments.
