FROM condaforge/miniforge3:24.11.3-0

# Set timezone to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install prerequisites for Phobius
RUN apt-get -y update && \
    apt-get install -y tzdata perl gnuplot && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Phobius
COPY phobius/ /usr/local/share/phobius/
RUN chmod +x /usr/local/share/phobius/phobius.pl && \
    ln -s /usr/local/share/phobius/phobius.pl /usr/local/bin/phobius