# Cassandra Cluster Monitoring with Prometheus and Grafana

This repository sets up a **multi-node Apache Cassandra cluster** with integrated **Prometheus monitoring** and **Grafana dashboard visualization** using Docker and Docker Compose.

---

## Components

- **Cassandra (with JMX Exporter)** — 3-node cluster with JMX metrics enabled via Prometheus Java agent.
- **Prometheus** — Collects JMX metrics from all Cassandra nodes.
- **Grafana** — Visualizes Cassandra metrics in a web dashboard.

---

## Project Structure

```
.
├── docker-compose.yaml
├── Dockerfile                     # Builds cassandra-with-jmx image
├── jmx-exporter/
│   └── cassandra-jmx-exporter.yaml   # JMX exporter config for Cassandra
├── prometheus/
│   └── prometheus.yml                # Prometheus scrape config
└── README.md
```

---

## Getting Started

### Step 1️ Clone the Repository

```bash
git clone https://github.com/gunasekaran-eminds/mulitnode-cassandra-with-grafana-prometheus.git
cd mulitnode-cassandra-with-grafana-prometheus
```

### Step 2️ Build Custom Cassandra Image

```bash
docker build -t cassandra-with-jmx .
```

### Step 3 Start All Services

```bash
docker-compose up -d
```

> This will start:
> - 3 Cassandra nodes (`cassandra1`, `cassandra2`, `cassandra3`)
> - Prometheus (`localhost:9090`)
> - Grafana (`localhost:3000`)

---

## Port Mappings

| Service     | Host Port | Container Port | Description              |
|-------------|-----------|----------------|--------------------------|
| cassandra1  | 9042      | 9042           | Native transport port    |
| cassandra2  | 9043      | 9042           |                          |
| cassandra3  | 9044      | 9042           |                          |
| cassandra1  | 7070      | 7070           | JMX exporter port        |
| cassandra2  | 7071      | 7070           |                          |
| cassandra3  | 7072      | 7070           |                          |
| prometheus  | 9090      | 9090           | Prometheus UI            |
| grafana     | 3000      | 3000           | Grafana dashboard UI     |

---

## Prometheus Configuration

`prometheus/prometheus.yml` is configured to scrape metrics from:

```yaml
- targets:
    - cassandra1:7070
    - cassandra2:7071
    - cassandra3:7072
```

---

## Grafana Setup

1. Access Grafana at: [http://localhost:3000](http://localhost:3000)
2. Login with default credentials:
   - **User:** `admin`
   - **Password:** `admin`
3. Add Prometheus as a data source (`http://prometheus:9090`)
4. Import a Cassandra monitoring dashboard using dashboard ID or JSON.

---

## Cleanup

```bash
docker-compose down -v
```

---

## Notes

- The Cassandra Docker image includes the JMX Prometheus Java Agent.
- Each node exports metrics on a **different port** to allow Prometheus to scrape them independently.
- The Grafana dashboard must be imported manually unless provisioned via a config script.

---

## License

MIT or Apache 2.0 (based on your use).
