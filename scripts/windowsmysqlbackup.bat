FOR /f %%a IN ('WMIC OS GET LocalDateTime ^| FIND "."') DO SET DTS=%%a
SET date=%DTS:~0,8%-%DTS:~8,6%

C:\xampp2\mysql\bin\mysqldump.exe DB1- -h localhost -u user -ppassword > C:\backups\DB1-%date%.sql
del C:\backups\DB1-latest.sql
copy C:\backups\DB1--%date%.sql "C:\backups\DB1-latest.sql"
fileup C:\backups\DB1--%date%.sql C:\backups\DB1--latest.sql