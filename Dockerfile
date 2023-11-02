FROM ubuntu:latest

RUN apt-get update -y
RUN apt-get install -y python3 python3-pip python3-dev build-essential

COPY /src/requirements.txt /usr/src/app/
RUN pip3 install --no-cache-dir -r /usr/src/app/requirements.txt

COPY /src/app.py /usr/src/app/

EXPOSE 5000

CMD ["python3", "/usr/src/app/app.py"]