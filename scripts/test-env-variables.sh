#!/bin/bash
# Script to test environment variables

echo "Testing environment variables..."

# Check if .env file exists
if [ -f ".env" ]; then
    echo "✅ .env file found"
    
    # Load environment variables
    export $(cat .env | xargs)
    
    # Check if key variables are set
    if [ -n "$DB_HOST" ] && [ -n "$DB_PORT" ] && [ -n "$DB_NAME" ] && [ -n "$DB_USER" ] && [ -n "$DB_PASSWORD" ]; then
        echo "✅ Environment variables loaded successfully"
        echo "Database Configuration:"
        echo "  Host: $DB_HOST"
        echo "  Port: $DB_PORT"
        echo "  Name: $DB_NAME"
        echo "  User: $DB_USER"
        echo "  Password: [HIDDEN]"
    else
        echo "❌ Some environment variables are missing"
        exit 1
    fi
else
    echo "❌ .env file not found"
    exit 1
fi

echo ""
echo "All environment variables are properly configured!"