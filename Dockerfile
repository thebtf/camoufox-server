FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    gosu \
    libgtk-3-0 libx11-xcb1 libxfixes3 libxrandr2 libxtst6 libx11-6 \
    libxcomposite1 libasound2 libdbus-glib-1-2 libpci3 libxss1 \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libgbm1 \
    libatspi2.0-0 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir camoufox[geoip]

RUN useradd -m -u 1001 -g 100 camoufox
WORKDIR /home/camoufox

# Fetch browser binary as camoufox user
USER camoufox
RUN python -m camoufox fetch
USER root

COPY launch_server.py entrypoint.sh ./
RUN chmod +x entrypoint.sh && chown -R camoufox:camoufox /home/camoufox

EXPOSE 59001

ENTRYPOINT ["./entrypoint.sh"]
