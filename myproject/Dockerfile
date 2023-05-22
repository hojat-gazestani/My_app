# Use an official Python runtime as a parent image
FROM python:3.8-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Set the hostname
ARG APP_NAME="My_App "
ARG CREATED_TIME
RUN hostname "${APP_NAME}+${CREATED_TIME}+$(cat /proc/self/cgroup | grep "docker" | sed s/\\//\\n/g | tail -1)_$(hostname | awk -F'-' '{print substr($NF, length($NF)-1, length($NF))}')"

# Expose the port that the server will run on
EXPOSE 8001

# Start the server
CMD ["gunicorn", "-b", "0.0.0.0:8001", "myproject.wsgi:application"]
