@echo off
REM Script to test environment variables

echo Testing environment variables...

REM Check if .env file exists
if exist .env (
    echo ✅ .env file found
    
    REM Load environment variables
    for /f "tokens=*" %%i in ('type .env') do (
        set %%i
    )
    
    REM Check if key variables are set
    if defined DB_HOST (
        if defined DB_PORT (
            if defined DB_NAME (
                if defined DB_USER (
                    if defined DB_PASSWORD (
                        echo ✅ Environment variables loaded successfully
                        echo Database Configuration:
                        echo   Host: %DB_HOST%
                        echo   Port: %DB_PORT%
                        echo   Name: %DB_NAME%
                        echo   User: %DB_USER%
                        echo   Password: [HIDDEN]
                    ) else (
                        echo ❌ DB_PASSWORD is not set
                        pause
                        exit /b 1
                    )
                ) else (
                    echo ❌ DB_USER is not set
                    pause
                    exit /b 1
                )
            ) else (
                echo ❌ DB_NAME is not set
                pause
                exit /b 1
            )
        ) else (
            echo ❌ DB_PORT is not set
            pause
            exit /b 1
        )
    ) else (
        echo ❌ DB_HOST is not set
        pause
        exit /b 1
    )
) else (
    echo ❌ .env file not found
    pause
    exit /b 1
)

echo.
echo All environment variables are properly configured!

pause