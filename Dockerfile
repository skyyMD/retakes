FROM joedwards32/cs2

# Root-Rechte für Paketinstallation
USER root

# Rsync installieren und Cache löschen
RUN apt-get update && \
    apt-get install -y rsync && \
    rm -rf /var/lib/apt/lists/*

# Zurück zu normalem Steam-User
USER steam

# Pre-Start Script kopieren
COPY pre.sh /home/steam/cs2-dedicated/pre.sh
RUN chmod +x /home/steam/cs2-dedicated/pre.sh

# ENTRYPOINT: pre.sh ausführen, dann normalen Server starten
ENTRYPOINT ["/bin/bash", "-c", "/home/steam/cs2-dedicated/pre.sh && /entrypoint.sh"]
