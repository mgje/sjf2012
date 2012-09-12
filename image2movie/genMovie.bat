@ECHO OFF
echo.
echo.
echo USAGE: genMovie.bat [filename] [imageext] [framerate] [bitrate] [videoformat] 
echo e.g.: 'genMovie.bat nano png 25 5000 webm', this means all source files
echo        are of the form nanoXYZ.png (XYZ are numbers) and the video will be stored as
echo        nano.webm with a frame rate of 25 an a bit rate of 5000k
echo.
echo.

if "%1"=="" set fn="nano"
if NOT "%1"=="" set fn=%1

if "%2"=="" set ie="png"
if NOT "%2"=="" set ie=%2

if "%3"=="" set fr="25"
if NOT "%3"=="" set fr=%3

if "%4"=="" set br="5000"
if NOT "%4"=="" set br=%4

if "%5"=="" set vf="webm"
if NOT "%5"=="" set vf=%5

ffmpeg.exe -r %fr% -b:v %br%k -i %fn%%%03d.%ie% %fn%.%vf%
echo DONE processing command
pause
