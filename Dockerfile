# base image
FROM python:3.9.19-slim

# set working dir
WORKDIR /app

# copy .txt file into container
COPY requirements.txt .

# install required packages
RUN pip install -r requirements.txt

# copy rest of application code into container
COPY . .

# expose port 
EXPOSE 8080

# run appplication
CMD [ "python", "app.py" ]