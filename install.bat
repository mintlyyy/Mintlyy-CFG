@echo off
setlocal enabledelayedexpansion
title mintlyy-cfg v3 - instalador (mastercomfig overrides)
echo ============================================================
echo   mintlyy-cfg v3 - instalador
echo   Copia cfg\overrides\* para  ...\Team Fortress 2\tf\cfg\overrides\
echo ============================================================
echo.

set "TF2="
if not "%~1"=="" set "TF2=%~1"

rem ---- 1) Descobre a pasta do TF2 pelo Steam (registro + libraryfolders.vdf) ----
if not defined TF2 (
  set "TMPF=%TEMP%\tf2path_mintlyy.txt"
  powershell -NoProfile -Command "$out=@(); $s=(Get-ItemProperty 'HKCU:\Software\Valve\Steam' -ErrorAction SilentlyContinue).SteamPath; if($s){ $v=Join-Path $s 'steamapps\libraryfolders.vdf'; if(Test-Path $v){ (Get-Content $v) | Select-String -Pattern '\"path\"\s+\"(.+?)\"' | ForEach-Object { $out += ($_.Matches[0].Groups[1].Value -replace '\\\\','\') } }; $out += $s }; foreach($l in $out){ $p = Join-Path $l 'steamapps\common\Team Fortress 2'; if(Test-Path (Join-Path $p 'tf\cfg')) { $p } }" > "%TMPF%" 2>nul
  set /p TF2=<"%TMPF%"
  del "%TMPF%" 2>nul
)

rem ---- 2) Caminhos comuns (se a descoberta acima falhar) ----
if not defined TF2 (
  for %%D in ("%ProgramFiles(x86)%\Steam" "C:\Steam" "C:\SteamLibrary" "D:\Steam" "D:\SteamLibrary" "E:\Steam" "E:\SteamLibrary" "F:\SteamLibrary" "G:\SteamLibrary") do (
    if not defined TF2 if exist "%%~D\steamapps\common\Team Fortress 2\tf\cfg" set "TF2=%%~D\steamapps\common\Team Fortress 2"
  )
)

rem ---- 3) Pergunta manualmente ----
if not defined TF2 (
  echo Nao achei o Team Fortress 2 automaticamente.
  echo Dica: Steam -^> Biblioteca -^> botao direito no TF2 -^> Gerenciar -^> Ver arquivos locais
  echo.
  set /p TF2=Cole aqui o caminho da pasta "Team Fortress 2": 
)

if not exist "%TF2%\tf\cfg" (
  echo.
  echo ERRO: nao existe "%TF2%\tf\cfg".
  echo Confira se o caminho esta certo (tem que terminar em \Team Fortress 2).
  pause
  exit /b 1
)

echo.
echo TF2 encontrado em: %TF2%

rem ---- 4) Aviso se o mastercomfig nao estiver instalado ----
dir /b "%TF2%\tf\custom\mastercomfig*.vpk" >nul 2>&1
if errorlevel 1 (
  echo.
  echo AVISO: nao achei nenhum mastercomfig*.vpk em tf\custom.
  echo        Esta config depende do mastercomfig. Baixe em https://comfig.app/app
  echo        (preset LOW pro seu GT 630) e extraia em tf\custom.
  echo.
)

rem ---- 5) Backup do que ja existe ----
set "DEST=%TF2%\tf\cfg\overrides"
if exist "%DEST%" (
  if exist "%DEST%\*.cfg" (
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value 2^>nul') do set "DT=%%I"
    set "BAK=%TF2%\tf\cfg\overrides_backup_!DT:~0,8!_!DT:~8,4!"
    echo Fazendo backup do overrides atual em:
    echo   !BAK!
    xcopy /y /i /q "%DEST%" "!BAK!\" >nul
  )
)

rem ---- 6) Instala ----
mkdir "%DEST%" 2>nul
xcopy /y /i /q "%~dp0cfg\overrides\*" "%DEST%\" >nul
if errorlevel 1 (
  echo ERRO ao copiar arquivos.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo   PRONTO! Arquivos copiados para:
echo   %DEST%
echo ============================================================
echo   No jogo, abra o console (~) e confira:
echo     - "mintlyy-cfg v3" na inicializacao
echo     - preset_level   (deve dizer preset=low/medium, NAO custom)
echo     - module_levels  (confere os modulos da v3)
echo   Alterou algo? Rode:  apply_overrides
echo ============================================================
echo.
pause
