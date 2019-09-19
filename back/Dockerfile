FROM python

# RUN apt-get update -y
# RUN apt-get install -y python-pip python-dev build-essential
# RUN sudo pip3 install flask

#WORKDIR ./usr/src/app

COPY . .

RUN pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 5000

# ENTRYPOINT ["python3"]

CMD ["python","app.py"]