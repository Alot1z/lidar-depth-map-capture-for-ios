#!/bin/bash

# Quick Upload Script for GitHub Repository
# Uploads all changes to GitHub with commit messages

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Quick Upload to GitHub${NC}"

# Check if we're in a git repo
if ! git rev-parse --git-head > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Not in a git repository${NC}"
    exit 1
fi

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)
echo -e "${GREEN}📂 Current branch: $CURRENT_BRANCH${NC}"

# Show current status
echo -e "${BLUE}📋 Git Status:${NC}"
git status --porcelain

# Add all changes
echo -e "${YELLOW}➕ Adding all changes...${NC}"
git add .

# Check if there are staged changes
if git diff --cached --quiet; then
    echo -e "${YELLOW}⚠️  No changes to commit${NC}"
    exit 0
fi

# Get commit message or use default
if [ $# -eq 0 ]; then
    COMMIT_MSG="Update TrollStore build system and enhanced entitlements"
    echo -e "${BLUE}📝 Using default commit message:${NC}"
    echo "   \"$COMMIT_MSG\""
    echo -e "${YELLOW}💡 Or provide custom message: $0 \"your commit message\"${NC}"
else
    COMMIT_MSG="$1"
    echo -e "${BLUE}📝 Using custom commit message:${NC}"
    echo "   \"$COMMIT_MSG\""
fi

# Commit
echo -e "${YELLOW}💾 Committing changes...${NC}"
git commit -m "$COMMIT_MSG

🚀 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to remote with authentication
echo -e "${YELLOW}⬆️  Pushing to origin/$CURRENT_BRANCH...${NC}"
echo -e "${BLUE}🔐 Authentication window will open if needed${NC}"
git push origin "$CURRENT_BRANCH"

echo -e "${GREEN}✅ Successfully uploaded to GitHub!${NC}"
echo -e "${BLUE}🔗 Repository: https://github.com/Alot1z/lidar-depth-map-capture-for-ios${NC}"

# Show actions if available
echo -e "${BLUE}🔧 Check GitHub Actions: https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions${NC}"

# Open GitHub Actions page
echo -e "${YELLOW}🌐 Opening GitHub Actions page...${NC}"
start https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions