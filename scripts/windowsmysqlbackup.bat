FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET date=%DTS:~0,8%-%DTS:~8,6%

C:\xampp2\mysql\bin\mysqldump.exe db1-h localhost -u user -ppassword > C:\backups\db1-%date%.sql