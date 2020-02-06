
FROM mcr.microsoft.com/windows/servercore:1809
LABEL Description="Windows Server Core development environment for Qbs with Qt, Chocolatey and various dependencies for testing Qbs modules and functionality"

# Disable crash dialog for release-mode runtimes
RUN reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f
RUN reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v DontShowUI /t REG_DWORD /d 1 /f

RUN powershell -NoProfile -ExecutionPolicy Bypass -Command \
    $Env:chocolateyVersion = '0.10.8' ; \
    $Env:chocolateyUseWindowsCompression = 'false' ; \
    "[Net.ServicePointManager]::SecurityProtocol = \"tls12, tls11, tls\"; iex ((New-Object System.Net.WebClient).DownloadString('http://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Wait for vs_installer.exe, vs_installerservice.exe
# or vs_installershell.exe because choco doesn't
RUN powershell -NoProfile -InputFormat None -Command \
    choco install visualcpp-build-tools --version 15.0.26228.20170424 -y; \
    Write-Host 'Waiting for Visual C++ Build Tools to finish'; \
    Wait-Process -Name vs_installer

RUN choco install -y python
RUN choco install -y 7zip --version 19.0
RUN choco install -y git --version 2.24.0 --params "/GitAndUnixToolsOnPath"
RUN pip install beautifulsoup4 lxml

# clcache for speeding up MSVC builds
ENV CLCACHE_DIR="C:/.ccache"
RUN certutil -generateSSTFromWU roots.sst && \
    certutil -addstore -f root roots.sst && \
    del roots.sst && \
    pip install --trusted-host=pypi.org \
        git+https://github.com/frerich/clcache.git@cae73d8255d78db8ba11e23c51fd2c9a89e7475b

## TODO: These packages install binaries that confuse qbs-setup-toolchains
##RUN choco install -y zip --version 3.0 && \
##    choco install -y unzip --version 6.0 && \

ARG QBS_VERSION
RUN choco install -y vcredist140
RUN choco install -y qbs --version %QBS_VERSION% && \
    qbs --version

RUN qbs setup-toolchains --detect

########### Install Qt #############
ARG QT_VERSION
COPY scripts/install-qt.sh install-qt.sh

RUN bash -c "./install-qt.sh -d /c/Qt --version ${QT_VERSION} --toolchain win64_msvc2017_64 qtbase qtdeclarative qttools qtscript"
ENV QMAKE_PATH=C:/Qt/${QT_VERSION}/msvc2017_64/bin/qmake.exe

RUN qbs setup-qt %QMAKE_PATH% qt
RUN qbs config profiles.qt.baseProfile MSVC2017-x64
RUN qbs config defaultProfile qt
RUN qbs config --list
