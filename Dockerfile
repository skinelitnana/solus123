FROM gitpod/openvscode-server:latest

USER root


RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        python3 python3-pip python3-venv python3-dev \
        curl wget nano git sudo htop screen build-essential && \
    # Alias 'python' agar kompatibel dengan script/tutorial umum
    ln -sf /usr/bin/python3 /usr/bin/python && \
    # Upgrade pip & hapus cache agar image tetap kecil
    pip3 install --no-cache-dir --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8888

# 2. Entrypoint standar OpenVSCode Server
ENTRYPOINT ["/bin/sh", "-c", "exec ${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server --host 0.0.0.0 --port 8888 --without-connection-token \"$@\" --"]
