FROM apache/kafka:4.0.0

# Copy JAAS config for SASL/PLAIN authentication
COPY jaas.conf /etc/kafka/jaas.conf

# Set environment variable to enable JAAS
ENV KAFKA_OPTS="-Djava.security.auth.login.config=/etc/kafka/jaas.conf"
