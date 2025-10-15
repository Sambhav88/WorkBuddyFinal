#!/bin/bash

# Navigate to the backend directory
cd "$(dirname "$0")/../backend"

# Load environment variables from .env file if it exists
if [ -f "../.env" ]; then
    export $(cat ../.env | xargs)
fi

# Run the Spring Boot application
mvn spring-boot:run