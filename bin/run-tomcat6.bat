@echo off
rem /**
rem  * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
rem  *
rem  * Author: Starsoft@163.com
rem  */
title %cd%
echo.
echo [��Ϣ] ʹ��Tomcat6������й��̡�
echo.
rem pause
rem echo.

cd %~dp0
cd..

set MAVEN_OPTS=%MAVEN_OPTS% -Xms256m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m
call mvn tomcat6:run

cd bin
pause