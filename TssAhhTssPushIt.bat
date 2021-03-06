@echo off

IF EXIST "%VS120COMNTOOLS%vsvars32.bat" call "%VS120COMNTOOLS%vsvars32.bat" & goto VARSSET
IF EXIST "%VS110COMNTOOLS%vsvars32.bat" call "%VS110COMNTOOLS%vsvars32.bat" & goto VARSSET
IF EXIST "%VS100COMNTOOLS%vsvars32.bat" call "%VS100COMNTOOLS%vsvars32.bat" & goto VARSSET
echo "Could not detect VS version!" & goto ERROR
:VARSSET

call msbuild.exe .\Conventional\Conventional.csproj /p:Configuration=Release /p:Platform=AnyCPU
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

call msbuild.exe .\Conventional.Cecil\Conventional.Cecil.csproj /p:Configuration=Release /p:Platform=AnyCPU
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

nuget pack .\Conventional\Conventional.csproj -Prop Configuration=Release
nuget push .\Best.Conventional.0.0.0.7.nupkg

nuget pack .\Conventional.Cecil\Conventional.Cecil.csproj -Prop Configuration=Release
nuget push .\Best.Conventional.Cecil.0.0.0.1.nupkg

echo .
echo Finished ResetTheWorldWithData on:
echo %DATE%
echo   _________                                        
echo  /   _____/__ __   ____  ____  ____   ______ ______
echo  \_____  \^|  ^|  \_/ ___\/ ___\/ __ \ /  ___//  ___/
echo  /        \  ^|  /\  \__\  \__\  ___/ \___ \ \___ \ 
echo /_______  /____/  \___  ^>___  ^>___  ^>____  ^>____  ^>
echo         \/            \/    \/    \/     \/     \/ 
echo .
echo    (o_o)
echo    ^<)   )/  Tss Ahh
echo     /   \
echo .
echo     ( o_o)
echo    \(   (^>  Tss Push It
echo     /   \
echo .

ping 192.0.2.2 -n 1 -w 5000 > nul

GOTO END

:ERROR

call .\Error.bat
pause

:END