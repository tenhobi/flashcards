@ECHO OFF & SETLOCAL EnableDelayedExpansion

ECHO Available methods:
ECHO 1) Generate arb template from source
ECHO 2) Generate Dart files from arb templates
ECHO 3) Quit
CHOICE /C 123 /M "Choose method to use"

IF ERRORLEVEL 3 EXIT /B 0
IF ERRORLEVEL 2 GOTO GENERATEDART
IF ERRORLEVEL 1 GOTO GENERATEARB
EXIT /B 0

:GENERATEARB
CD %~dp0\..\common

SET ORIG=lib\src\i18n\translations\intl_messages.arb
SET TEMPLATE=lib\src\i18n\translations\template.arb

CALL pub run intl_translation:extract_to_arb --output-dir=lib\src\i18n\translations lib\src\i18n\string.dart

MOVE %ORIG% %TEMPLATE% > NUL

ECHO Done generating arb file.
ECHO Bye!
EXIT /B 0

:GENERATEDART
CD %~dp0\..\common

SET DARTPATH=lib\src\i18n\
FOR /F "delims=" %%I IN ('DIR /B %DARTPATH%*.dart') DO (
SET DARTFILES=!DARTFILES! %DARTPATH%%%I
)

SET ARBPATH=lib\src\i18n\translations\
FOR /F "delims=" %%I IN ('DIR /B %ARBPATH%*_*.arb') DO (
SET ARBFILES=!ARBFILES! %ARBPATH%%%I
)

CALL pub run intl_translation:generate_from_arb --output-dir=lib\src\i18n\generated --generated-file-prefix="" !DARTFILES! !ARBFILES!
ECHO Done generating dart files.

ECHO Formatting

SET GENERATEDPATH=lib\src\i18n\generated\
FOR /F "delims=" %%I IN ('DIR /B %GENERATEDPATH%*.dart') DO (
SET GENERATEDFILES=!GENERATEDFILES! %GENERATEDPATH%%%I
)

CALL dartfmt --line-length 120 -w !GENERATEDFILES!

ECHO Bye!
EXIT /B 0
