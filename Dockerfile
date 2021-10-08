FROM python:3.8
MAINTAINER "enumus"

# Install git
RUN apt-get update \
    & apt-get install -y git
#RUN git clone https://github.com/enumus/py-mikrotik-reporter.git /app

COPY ./py-mikrotik-reporter /app

# Set working directory
WORKDIR /app

RUN pip3 install -r requirements.txt

RUN mv /app/config.tpl /app/config.ini

# COPY . .

CMD [ "python", "-m", "flask", "run", "--host=0.0.0.0"]