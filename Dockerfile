FROM wazuh/wazuh-manager:4.7.5

# Copy configuration files into the image
COPY config/wazuh_cluster/ossec.conf /var/ossec/etc/ossec.conf
COPY config/wazuh_cluster/local_rules.xml /var/ossec/etc/rules/local_rules.xml
COPY config/filebeat/filebeat.yml /etc/filebeat/filebeat.yml

# Set correct permissions for Filebeat configuration
USER root
RUN chown root:root /etc/filebeat/filebeat.yml && \
    chmod go-w /etc/filebeat/filebeat.yml

# Switch back to the default user if necessary (Wazuh manager usually runs as root in Docker)
