# PostgreSQL Setup Guide for WorkBuddy

## Prerequisites
- Docker and Docker Compose installed
- Java 17 or higher
- Maven 3.6 or higher

## PostgreSQL Configuration

The project is already configured to use PostgreSQL with environment variables for configuration. Here are the key configuration details:

### Database Connection Settings (application.properties)
```properties
spring.datasource.url=jdbc:postgresql://${DB_HOST}:${DB_PORT}/${DB_NAME}
spring.datasource.username=${DB_USER}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.properties.hibernate.format_sql=true
```

### Environment Variables (.env file)
The project includes a `.env` file with default values:
```env
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=workbuddy
DB_USER=postgres
DB_PASSWORD=postgres
```

### Maven Dependencies (pom.xml)
```xml
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

## Running PostgreSQL with Docker

### Using Docker Compose (Recommended)
1. Make sure Docker is running
2. Navigate to the project root directory
3. Run the following command:
   ```bash
   docker-compose up -d
   ```
   
This will start:
- PostgreSQL 17 database server on port 5432
- pgAdmin web interface on port 5050

### Accessing PostgreSQL
- **Database URL**: jdbc:postgresql://localhost:5432/workbuddy
- **Username**: postgres
- **Password**: postgres
- **Database Name**: workbuddy

### Accessing pgAdmin
- **URL**: http://localhost:5050
- **Email**: admin@example.com
- **Password**: admin

## Running the Application

### Method 1: Using Batch Files (Windows)
1. Start PostgreSQL using Docker Compose:
   ```bash
   docker-compose up -d
   ```
2. Double-click on `scripts/start-all.bat` to start both frontend and backend servers
3. Access the application at http://localhost:8000
4. The backend API will be available at http://localhost:8082

### Method 2: Manual Start
1. Start PostgreSQL using Docker Compose:
   ```bash
   docker-compose up -d
   ```
2. Start the backend:
   ```bash
   cd backend
   mvn spring-boot:run
   ```
3. Start the frontend:
   ```bash
   cd frontend
   python server.js
   ```

## Troubleshooting

### Common Issues
1. **Port already in use**: If port 5432 is already in use, stop the existing PostgreSQL service or change the port in docker-compose.yml
2. **Connection refused**: Make sure Docker is running and the PostgreSQL container is started
3. **Authentication failed**: Verify the username and password in application.properties match those in docker-compose.yml

### Checking Container Status
```bash
docker-compose ps
```

### Viewing Container Logs
```bash
docker-compose logs postgres
```

### Stopping Containers
```bash
docker-compose down
```