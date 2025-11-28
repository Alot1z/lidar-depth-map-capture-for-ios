@echo off
echo 🔧 Fixing project paths in GitHub Actions...

REM Add everything to git
git add .

REM Commit with message
git commit -m "CRITICAL FIX: Correct project paths for GitHub Actions

- Fix: Use lidar-depth-map-capture-for-ios/ directory for actual project
- Update both TrollStore and Sideload workflows with correct paths
- Install CocoaPods in correct project directory
- Build from proper project location
- This should resolve 'No Xcode project found' errors

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

REM Push to GitHub
echo 🔐 Pushing to GitHub - authentication window will open...
git push origin main

echo ✅ Done! Check your GitHub Actions: https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

REM Open GitHub Actions page
echo 🌐 Opening GitHub Actions page...
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

pause