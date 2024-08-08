# Use an official Python runtime as a parent image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

# Set the Flask app environment variable
ENV FLASK_APP=server.py

# Expose the port the app runs on
EXPOSE 5000

# Define the command to run the app
CMD ["flask", "run", "--host=0.0.0.0"]

# docker build -t brainupgrade/copilot-weather .
# docker run -p 5000:5000 brainupgrade/copilot-weather