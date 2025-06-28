# Kafka with Kafka UI - Docker Compose Setup

This repository contains a Docker Compose setup for running Apache Kafka with Kafka UI for easy management and monitoring.

## Features

- Apache Kafka 4.0.0 with KRaft mode (no Zookeeper required)
- SASL/PLAIN authentication enabled
- Kafka UI for web-based management
- Persistent data storage
- Health checks for reliable startup

## Quick Start

1. **Start the services:**
   ```bash
   docker-compose up -d
   ```

2. **Access Kafka UI:**
   Open your browser and go to [http://localhost:8080](http://localhost:8080)

3. **Stop the services:**
   ```bash
   docker-compose down
   ```

4. **Stop and remove all data:**
   ```bash
   docker-compose down -v
   ```

## Configuration

### Kafka Configuration
- **Bootstrap Server:** `kafka:9092` (within Docker network) or `localhost:9092` (from host)
- **Authentication:** SASL/PLAIN
- **Username:** `admin`
- **Password:** `admin-secret`

### Kafka UI Configuration
- **Web Interface:** http://localhost:8080
- **Cluster Name:** `local`
- **Auto-connects to Kafka with SASL authentication**

### Additional Users
You can add more users by modifying the `jaas.conf` file:
```
user_newuser="newuser-password";
```

## Connecting to Kafka

### From Host Machine
```bash
# Using kafka-console-producer (if you have Kafka CLI tools installed)
kafka-console-producer.sh --bootstrap-server localhost:9092 \
  --topic test-topic \
  --producer.config client.properties

# Using kafka-console-consumer
kafka-console-consumer.sh --bootstrap-server localhost:9092 \
  --topic test-topic \
  --from-beginning \
  --consumer.config client.properties
```

### Client Properties File
Create a `client.properties` file for connecting from external clients:
```properties
security.protocol=SASL_PLAINTEXT
sasl.mechanism=PLAIN
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="admin" password="admin-secret";
```

### From Other Docker Containers
Use `kafka:9092` as the bootstrap server and include the SASL configuration.

## Troubleshooting

1. **Check service status:**
   ```bash
   docker-compose ps
   ```

2. **View logs:**
   ```bash
   docker-compose logs kafka
   docker-compose logs kafka-ui
   ```

3. **Restart services:**
   ```bash
   docker-compose restart
   ```

## Ports

- **Kafka:** 9092 (PLAINTEXT), 9093 (CONTROLLER)
- **Kafka UI:** 8080

## Data Persistence

Kafka data is persisted in a Docker volume named `kafka-data`. This ensures your topics and messages survive container restarts.
