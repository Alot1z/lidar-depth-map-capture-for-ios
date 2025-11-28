# 🚀 Build Workflows

This project now has **2 simple workflows** instead of 4 complex ones:

## 📱 **1. TrollStore Enhanced Build**
**File:** `trollstore-build.yml`

**Triggers:**
- Push to `main`, `develop`, `trollstore` branches
- Pull requests to those branches
- Manual workflow dispatch

**Features:**
- ✅ **Maximum entitlements** - unsandbox, unlimited file access
- ✅ **Enhanced ARKit** - unlimited depth capture rate
- ✅ **System integration** - background processing, unlimited memory
- ✅ **No restrictions** - full system access via TrollStore
- ✅ **Unsigned IPA** - ready for TrollStore installation

**Output:** `DepthCamera-TrollStore-[build-number].ipa`

## 🔓 **2. Normal Sideload Build**
**File:** `sideload-build.yml`

**Triggers:**
- Push to `main`, `develop` branches
- Tags (`v*`)
- Pull requests to those branches
- Manual workflow dispatch

**Features:**
- ✅ **Standard entitlements** - App Store sandbox
- ✅ **Basic LiDAR** - standard depth capture
- ✅ **Ad-hoc IPA** - ready for AltStore/Sideloadly
- ✅ **Universal compatibility** - works with any sideload tool

**Output:** `DepthCamera-Sideload-[build-number].ipa`

## 🎯 **Which Build to Use:**

### **Choose TrollStore if:**
- You have TrollStore installed
- Want maximum LiDAR depth capture capabilities
- Need unlimited file system access
- Want background processing and enhanced features
- Professional/advanced usage

### **Choose Normal Sideload if:**
- Using AltStore, Sideloadly, or other sideload tools
- Want basic depth capture functionality
- Need standard App Store compliance
- Casual/testing usage
- No TrollStore available

## 🚀 **Usage:**

### **Automatic Builds:**
- Push to branches → automatic build
- Create tag → automatic release
- Manual trigger → choose build type

### **Manual Build:**
1. Go to Actions tab in GitHub
2. Choose workflow (TrollStore or Sideload)
3. Click "Run workflow"
4. Download IPA from artifacts

## 📁 **Build Artifacts:**

Each build generates:
- **IPA file** - ready to install
- **build-info.json** - build metadata
- **GitHub Release** - for tagged builds

---

**Simple & Clean:** 2 workflows, 2 purposes, maximum flexibility! 🎯