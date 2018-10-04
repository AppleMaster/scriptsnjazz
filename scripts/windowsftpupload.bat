@echo off
echo user username> ftpcmd.dat
echo password>> ftpcmd.dat
echo cd /shh/>> ftpcmd.dat
echo bin>> ftpcmd.dat
echo put %1>> ftpcmd.dat
echo cd /shh/latest/>> ftpcmd.dat
echo put %2>> ftpcmd.dat
echo quit>> ftpcmd.dat
ftp -n -s:ftpcmd.dat XXX.XX.XXX.XX
del ftpcmd.dat