FROM ubuntu:24.04

RUN apt-get update && apt-get install -y cups cups-client cups-filters ghostscript

# Copy config
COPY config/cupsd.conf /etc/cups/cupsd.conf
COPY config/printers.conf /etc/cups/printers.conf

#COPY ppds/ /usr/share/cups/model/ #Add later

EXPOSE 631
VOLUME ["/var/spool/cups", "/etc/cups", "/usr/share/cups/model"]

CMD ["cupsd", "-f"]