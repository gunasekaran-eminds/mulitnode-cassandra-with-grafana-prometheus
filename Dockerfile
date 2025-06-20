FROM cassandra:4.1

RUN apt-get update && apt-get install -y curl

RUN curl -L -o /opt/jmx_prometheus_javaagent-0.20.0.jar \
    https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.20.0/jmx_prometheus_javaagent-0.20.0.jar

COPY jmx-exporter/cassandra-jmx-exporter.yaml /opt/

EXPOSE 7070