@echo off

cd /d D:\Assignments\SIH3\workbuddy\backend

REM Load environment variables from .env file if it exists
if exist ..\.env (
    for /f "tokens=*" %%i in ('type ..\.env') do (
        set %%i
    )
)

mvn spring-boot:run
pause