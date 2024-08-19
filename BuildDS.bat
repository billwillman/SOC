@echo off
echo CurrentDir: %~dp0
cd %~dp0
Unity.exe -quit -batchmode -nographics -executeMethod AssetBundleBuild.Cmd_DS -logFile ./outPath/dsLog.txt -projectPath ./outPath\Proj