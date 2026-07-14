FROM downloaderzone/dzwzmlx:latest

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY requirements.txt .
RUN uv venv /wzvenv && \
    uv pip install --python /wzvenv/bin/python --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
