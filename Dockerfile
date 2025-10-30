FROM ubuntu:24.04

RUN apt-get update && apt-get install -y cups cups-client cups-filters ghostscript && apt-get clean

# Copy static config templates
COPY config/cupsd.conf /etc/cups/cupsd.conf
COPY config/printers.conf.template /etc/cups/printers.conf

# Create writable runtime dirs
RUN mkdir -p /data/cups && chown -R lp:lp /data

# Tell CUPS where to store runtime state
ENV CUPS_DATADIR=/data/cups

EXPOSE 631

# Persist job + spool data only (not config)
VOLUME ["/var/spool/cups"]

CMD ["cupsd", "-f"]
