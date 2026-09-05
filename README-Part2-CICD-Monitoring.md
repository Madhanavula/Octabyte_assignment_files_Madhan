# CI/CD and Monitoring

## Part 1: Deployment Automation

### Overview

A simple Java web application was created to demonstrate an automated CI/CD pipeline using Maven, Jenkins, Docker, Docker Hub, GitHub, and AWS EC2.

### Technology Stack

* Java 17
* Maven
* Jenkins
* GitHub
* Docker
* Docker Hub
* AWS EC2
* SMTP Mailer

### Jenkins CI/CD Pipeline

The Jenkins pipeline performs:

1. Clean workspace
2. Clone source code from GitHub
3. Verify Maven
4. Build Java application using Maven
5. Build Docker image
6. Push image to Docker Hub
7. Deploy the latest image
8. Send email notification when the pipeline fails

### Challenges Faced

#### Maven Build Issues

The application build failed during the initial setup because the required Maven environment was not properly configured.

#### Jenkins Docker Permission Issue

Jenkins initially did not have permission to access Docker.

**Resolution:** Added the Jenkins user to the Docker group.

---

# Part 2: Monitoring Setup

## Overview

This project implements Linux server monitoring using Prometheus, Node Exporter, and Grafana.

The monitoring stack collects infrastructure-level metrics such as:

* CPU
* Memory
* Disk
* Network traffic
* System load
* Uptime

## 1. Node Exporter Setup

Node Exporter collects hardware and operating-system-level metrics from the Linux server.

Verify Node Exporter:

```bash
curl http://<ip>:9100/metrics
```

## 2. Prometheus Setup

Prometheus collects metrics from Node Exporter at regular intervals.

Configuration:

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: node
    static_configs:
      - targets: ['localhost:9100']
```

The configuration file used is:

```text
export-config.yml
```

Start Prometheus:

```bash
./prometheus --config.file=export-config.yml
```

## 3. Verify Prometheus Target

Open:

```text
http://<ip>:9090/targets
```

The Node Exporter target should show:

```text
node
localhost:9100
UP
```

This confirms that Prometheus is successfully scraping Node Exporter.

## 4. Grafana Setup

Grafana is used to visualize the metrics collected by Prometheus.

Open:

```text
http://<ip>:3000
```

Log in to Grafana.

### Add Prometheus Data Source

Navigate to:

```text
Connections → Data Sources → Add data source
```

Select:

```text
Prometheus
```

Set the Prometheus URL:

```text
http://<ip>:9090
```

Click:

```text
Save & Test
```

A successful connection confirms that Grafana can communicate with Prometheus.

## 5. Grafana Dashboards

### Linux Memory Dashboard

Grafana dashboard ID:

```text
2747
```

The dashboard provides:

* Total memory
* Used memory
* Available memory
* Memory utilization
* Swap usage

### Node Exporter Full Dashboard

Grafana dashboard ID:

```text
1860
```

It provides a complete Linux infrastructure monitoring view.

Metrics displayed:

* CPU utilization
* Memory utilization
* Disk usage
* Disk I/O
* Network traffic
* System load
* Filesystem usage
* System uptime
* CPU load
* Network interfaces

The dashboards use the Prometheus datasource configured above.

---

# Challenges Faced

## 1. Prometheus Configuration Spelling Error

Initially, `scrap_interval` and `scrap_configs` were used instead of:

```yaml
scrape_interval
scrape_configs
```

**Resolution:** Corrected the configuration and validated it using `promtool`.

## 2. Wrong Prometheus Configuration File

Prometheus was initially using `prometheus.yml` instead of:

```text
export-config.yml
```

**Resolution:** Started Prometheus with the correct configuration file.

## 3. Node Exporter Target DOWN

Prometheus was initially configured with the EC2 public IP:

```text
13.234.66.107:9100
```

Since Prometheus and Node Exporter were running on the same server, it was changed to:

```text
localhost:9100
```

## 4. Grafana Showing No Data

Grafana initially showed **No Data** because Prometheus was not successfully scraping Node Exporter.

**Resolution:** Fixed the Prometheus scraping configuration and verified that the Node Exporter target was `UP`.

Grafana dashboards then displayed the metrics successfully.
