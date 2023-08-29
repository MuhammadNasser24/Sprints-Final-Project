
# Dockerized MySQL and Flask App

## Dockerization - Simplifying Deployment

Dockerization is a method of packaging applications and their dependencies into standardized containers, providing an isolated environment that ensures consistent behavior across various environments. It simplifies deployment, scaling, and management of applications.

## Docker Installation

To use Docker, you need to have it installed on your machine. If you haven't installed Docker yet, follow the official installation guide for your specific operating system:

- [Install Docker](https://docs.docker.com/get-docker/)

## Using docker-compose to Build and Run

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications using a single YAML file. Here's how you can use it to build and run your application:

1. Clone the MySQL-FlaskApp repository:

   ```sh
   git clone https://github.com/uym2/MySQL-and-Python.git
   ```

2. Navigate to the repository directory:

   ```sh
   cd MySQL-and-Python
   ```

3. Create your 2 Docker files as application (1st one is for Flask-app, And the 2nd one is for MySQL_DB).
 Then create 'docker-compose.yaml' :

```sh
# instruction of the files is should be like this:
MySQL-and-Python/
├── Flask-App/
│   ├── Dockerfile               # Dockerfile for Flask App
│   └── ...                      # Other Flask App files
├── MySQL_db/
│   ├── Dockerfile               # Dockerfile for MySQL Database
│   └── ...                      # Other MySQL Database files
└── docker-compose.yaml          # Docker Compose configuration

```
4. Open a terminal and execute the following command to build and run the application containers:

   ```sh
   docker-compose up --build
   ```

   This command builds the Docker images and starts the containers defined in the `docker-compose.yaml` file.

## Docker Files Overview

### Flask App Dockerfile (FlaskApp/Dockerfile):

- Uses the official Python image as the base.
- Installs system-level dependencies and upgrades pip.
- Sets up the working directory and installs Python packages.
- Copies the Flask app code and exposes port 5000 for the app to run.
- Specifies the command to run the application.

### MySQL Database Dockerfile (MySQL_Queries/Dockerfile.mysql):

- Uses the official MySQL 5.7 image.
- Copies SQL scripts into the Docker container to initialize the database.

### Docker Compose File (docker-compose.yaml):

- Defines two services: `app` and `db`.
- Builds the Flask app and MySQL images based on the Dockerfiles.
- Sets up environment variables for each service, including database configuration.
- Maps ports for app and database communication.

> **Note:** This setup assumes that the Docker images and configurations are suitable for your project's requirements. Be sure to tailor the Dockerfiles, compose configuration, and environment variables to your application's specific needs.

