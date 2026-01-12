@echo off
chcp 65001
setlocal enabledelayedexpansion

REM 设置变量
set "SRC_DIR=src"
set "TOP=spi_screen"
set "TB=tb_%TOP%"
set "VCD=sim\%TOP%.vcd"
set "VERILOGS=%SRC_DIR%\%TOP%.v %SRC_DIR%\%TB%.v"

REM 检查命令参数
if "%1"=="" goto :sim
if /i "%1"=="sim" goto :sim
if /i "%1"=="clean" goto :clean
if /i "%1"=="help" goto :help

echo 未知命令: %1
goto :help

:sim
REM 运行仿真
echo 开始Verilog仿真...
echo 源文件: %VERILOGS%
echo 输出VCD文件: %VCD%

REM 创建sim目录（如果不存在）
if not exist sim mkdir sim

REM 使用iverilog编译
iverilog -o sim\%TOP%.tmp %VERILOGS%
if errorlevel 1 (
    echo iverilog编译失败！
    exit /b 1
)

REM 使用vvp运行仿真
vvp sim\%TOP%.tmp
if errorlevel 1 (
    echo vvp仿真运行失败！
    exit /b 1
)

REM 使用gtkwave查看波形
echo 正在启动gtkwave查看波形...
start gtkwave %VCD%
goto :end

:clean
REM 清理生成的文件
echo 清理仿真生成的文件...
if exist sim\*.vcd del /q sim\*.vcd
if exist sim\*.tmp del /q sim\*.tmp
if exist sim\*.gtkw del /q sim\*.gtkw
echo 清理完成！
goto :end

:help
REM 显示帮助信息
echo 用法:
echo   %0 [sim^|clean^|help]
echo.
echo 命令:
echo   sim   - 运行Verilog仿真并显示波形（默认）
echo   clean - 清理生成的仿真文件
echo   help  - 显示此帮助信息
echo.
echo 示例:
echo   %0        - 运行仿真
echo   %0 sim    - 运行仿真
echo   %0 clean  - 清理文件
echo   %0 help   - 显示帮助
goto :end

:end
endlocal