@echo off
echo 🚀 Uploading all changes to GitHub...

REM Add everything to git
git add .

REM Commit with message
git commit -m "Fix TrollStore build system - corrected workflow and entitlements

- Add fixed GitHub Actions workflow (trollstore-build-fixed.yml)
- Enhanced entitlements for maximum TrollStore capabilities
- Build scripts and documentation
- ARViewModel+TrollStore.swift for enhanced features
- Quick upload scripts for convenience

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

REM Push to GitHub with authentication
echo 🔐 Pushing to GitHub - authentication window will open...
git push origin main

echo ✅ Done! Check your GitHub Actions: https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

REM Open GitHub Actions page
echo 🌐 Opening GitHub Actions page...
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

pause