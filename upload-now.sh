#!/bin/bash

# Quick upload script - run this to upload all changes immediately
echo "🚀 Uploading all changes to GitHub..."

# Add everything
git add .

# Commit with message
git commit -m "Fix TrollStore build system - corrected workflow and entitlements

- Add fixed GitHub Actions workflow (trollstore-build-fixed.yml)
- Enhanced entitlements for maximum TrollStore capabilities
- Build scripts and documentation
- ARViewModel+TrollStore.swift for enhanced features
- Quick upload scripts for convenience

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to GitHub with authentication
echo "🔐 Pushing to GitHub - authentication window will open..."
git push origin main

echo "✅ Done! Check your GitHub Actions: https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions"

# Open GitHub Actions page
echo "🌐 Opening GitHub Actions page..."
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions