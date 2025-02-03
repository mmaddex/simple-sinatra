# Use Ruby base image
FROM ruby:3.1.2

# Install OpenSSH server
RUN apt update && apt install -y openssh-server && rm -rf /var/lib/apt/lists/*

# Unlock the root account to comply with Dockerfile requirements
RUN usermod --unlock root

# Create SSH directory and set up a non-root user
RUN useradd -m -s /bin/bash dockeruser && \
    mkdir -p /home/dockeruser/.ssh && chmod 0700 /home/dockeruser/.ssh && \
    chown -R dockeruser:dockeruser /home/dockeruser/.ssh

# Ensure root also has an SSH directory
RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh && chown root:root /root/.ssh

# Copy the public key from the secret location into the authorized_keys file for dockeruser
RUN --mount=type=secret,id=_pubkey,dst=/etc/secrets/.pubkey cp /etc/secrets/.pubkey /home/dockeruser/.ssh/authorized_keys

# Ensure proper permissions on authorized_keys
RUN chmod 0600 /home/dockeruser/.ssh/authorized_keys && \
    chown dockeruser:dockeruser /home/dockeruser/.ssh/authorized_keys

# Configure SSH to allow key authentication and ensure root access is enabled
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    echo "AllowUsers dockeruser root" >> /etc/ssh/sshd_config

# Set working directory
WORKDIR /code

# Copy application files
COPY . ./

# Install dependencies
RUN bundle install

# Set permissions for the entrypoint script
RUN chmod +x /code/run.sh

# Expose SSH and application ports
EXPOSE 22 3000

# Start both SSH and the Ruby application
CMD service ssh start && /code/run.sh
