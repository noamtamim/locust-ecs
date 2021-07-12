FROM python:3.9.5-slim

RUN pip install -U pip wheel && pip install locust

RUN echo >> /etc/security/limits.conf && \
    echo "locust  soft  nofile 50000" >> /etc/security/limits.conf && \
    echo "locust  hard  nofile 50000" >> /etc/security/limits.conf && \
    echo "fs.file-max=500000" > /etc/sysctl.d/local.conf

# turn off python output buffering
ENV PYTHONUNBUFFERED=1

WORKDIR /locust
COPY entrypoint.py .
RUN chmod +x entrypoint.py
ENTRYPOINT ["./entrypoint.sh"]
