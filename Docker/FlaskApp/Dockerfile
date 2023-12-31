# Use the official Python image as the base image
FROM python:latest

# Set the working directory inside the container
WORKDIR /app

# Install system-level dependencies and upgrade pip
RUN apt-get update && apt-get install -y default-libmysqlclient-dev && pip install --upgrade pip

# Copy the Docker directory into the container
COPY Docker /app/Docker

# Set the working directory to the FlaskApp directory
WORKDIR /app/Docker/FlaskApp

# Copy the requirements file into the container
COPY . /requirements.txt/

# Install the required Python packages
RUN pip install -r requirements.txt

# Copy the application code into the container
COPY . .

# Expose the port that the app will run on
EXPOSE 5000

# Command to run the application
CMD ["python", "app.py"]
