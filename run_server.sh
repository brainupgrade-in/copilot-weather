#!/bin/bash

# Activate virtual environment if needed
# source venv/bin/activate

# Set the Flask app environment variable
export FLASK_APP=server.py

# Run the Flask web server
flask run