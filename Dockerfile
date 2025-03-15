FROM ollama/ollama

RUN apt-get update && apt-get install -y curl

COPY ./scripts/download_model.sh /scripts/download_model.sh

RUN chmod +x /scripts/download_model.sh

EXPOSE 11434
ENTRYPOINT ["/bin/sh", "/scripts/download_model.sh"]
