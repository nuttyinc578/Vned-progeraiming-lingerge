# PNB Console Dockerfile
FROM python:3.11-slim

LABEL maintainer="PNB Project"
LABEL description="PNB Console - Control Panel"

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000
CMD ["python", "console.py"]
