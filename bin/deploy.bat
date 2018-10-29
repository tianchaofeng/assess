@echo off
rem /**
rem  * Copyright &copy; 2012-2014 <a href="http://www.stars-soft.com">EziCloud</a> All rights reserved.
rem  *
rem  * Author: Starsoft@163.com
rem  */
echo.
echo [��Ϣ] ����Eclipse�����ļ���
echo.
pause
echo.

cd %~dp0
cd..

call mvn deploy

cd bin
pause