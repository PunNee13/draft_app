# -- Status: docker image not created/tested yet -- #

FROM python:3.9-slim-bullseye

# Allow statements and log messages to immediatly appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to container image
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY ./app ./

RUN apt-get -y update
RUN apt-get -y install git
RUN pip install -r requirements.txt

CMD exec gunicorn --bin :$PORT --workers 1 --threads 4 --timeout 0 app:app