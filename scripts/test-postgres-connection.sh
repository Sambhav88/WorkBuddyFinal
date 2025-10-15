#!/bin/bash
# Script to test PostgreSQL connection

echo "Testing PostgreSQL connection..."

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please start Docker first."
    exit 1
fi

# Check if PostgreSQL container is running
if docker-compose ps | grep -q "postgres.*Up"; then
    echo "PostgreSQL container is running."
else
    echo "PostgreSQL container is not running. Starting it now..."
    docker-compose up -d postgres
    sleep 10  # Wait for PostgreSQL to start
fi

# Test connection
echo "Testing database connection..."
if docker-compose exec postgres pg_isready > /dev/null 2>&1; then
    echo "✅ PostgreSQL is ready and accepting connections."
else
    echo "❌ Failed to connect to PostgreSQL."
    echo "Please check the container logs with: docker-compose logs postgres"
    exit 1
fi

# Show container status
echo ""
echo "Container status:"
docker-compose ps