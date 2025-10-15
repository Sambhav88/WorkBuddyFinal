@echo off
REM Script to test PostgreSQL connection on Windows

echo Testing PostgreSQL connection...

REM Check if Docker is running
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Docker is not running. Please start Docker first.
    pause
    exit /b 1
)

REM Check if PostgreSQL container is running
docker-compose ps | findstr "postgres.*Up" >nul
if %errorlevel% equ 0 (
    echo PostgreSQL container is running.
) else (
    echo PostgreSQL container is not running. Starting it now...
    docker-compose up -d postgres
    timeout /t 10 /nobreak >nul
)

REM Test connection
echo Testing database connection...
docker-compose exec postgres pg_isready >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ PostgreSQL is ready and accepting connections.
) else (
    echo ❌ Failed to connect to PostgreSQL.
    echo Please check the container logs with: docker-compose logs postgres
    pause
    exit /b 1
)

REM Show container status
echo.
echo Container status:
docker-compose ps

pause