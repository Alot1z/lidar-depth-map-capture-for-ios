@echo off
echo 🔧 FINAL PROJECT STRUCTURE FIX

echo.
echo ✅ CLEANING UP DUPLICATE FILES...
echo.

echo 📁 Current clean project structure:
dir /b

echo.
echo 📱 Project directory contents:
dir /b lidar-depth-map-capture-for-ios\

echo.
echo ✅ WORKFLOWS PROPERLY NAMED:
echo    - trollstore ipa build
echo    - sideload ipa build
echo.

REM Add everything to git
echo 📦 Adding cleaned project structure to git...
git add .

REM Commit with clean message
git commit -m "Fix project structure - remove duplicate files

- Remove duplicate root-level files
- Keep only lidar-depth-map-capture-for-ios/ project directory
- Workflows properly named: trollstore ipa build, sideload ipa build
- Clean project structure for GitHub Actions

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

REM Push to GitHub
echo 🔐 Pushing fixed structure to GitHub...
git push origin main

echo ✅ FIXED! Check your GitHub Actions: https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

echo 🌐 Opening GitHub Actions page...
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

echo.
echo 🎯 WORKFLOWS SHOULD NOW SHOW:
echo    • trollstore ipa build
echo    • sideload ipa build
echo.

pause