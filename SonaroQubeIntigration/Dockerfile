FROM python:3.9.19-slim-bullseye
RUN apt update
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt
CMD ["python3", "app.py"]
