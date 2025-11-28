@echo off
echo 🚀 Upload Changes to GitHub
echo.

git status
echo.

git add .
git commit -m "iOS LiDAR app updates - GitHub Actions fixes and optimizations

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

echo.
echo ✅ Upload Complete!
echo 🚀 Check GitHub Actions for build status
echo.

pause