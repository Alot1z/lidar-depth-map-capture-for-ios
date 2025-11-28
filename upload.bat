@echo off
echo 🚀 Upload to GitHub

git add .
git commit -m "Clean project structure and build fixes

- Remove duplicate files and directories
- Fix project structure for GitHub Actions
- Workflows: trollstore ipa build, sideload ipa build

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

git push origin main
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions

pause