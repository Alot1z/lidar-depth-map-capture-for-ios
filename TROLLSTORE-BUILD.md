# 🚀 TrollStore-Enhanced LiDAR Depth Map Capture

This guide explains how to build and install the TrollStore-optimized version of the LiDAR Depth Map Capture iOS app with maximum entitlements and enhanced capabilities.

## 🎯 What is TrollStore?

TrollStore is a permasigned jailbreak alternative that allows users to install unsigned IPAs permanently on iOS devices with enhanced system access and unrestricted entitlements.

## ✨ TrollStore-Enhanced Features

### 🔓 System-Level Access
- **Unlimited File System Access**: Save depth maps anywhere on the device
- **No Sandbox Restrictions**: Direct system integration
- **Enhanced Memory Management**: Process unlimited-size depth maps
- **Background Processing**: Continuous depth capture and processing

### 📱 Enhanced ARKit Capabilities
- **Unlimited Depth Capture**: Maximum frame rate and resolution
- **Raw Depth Data Access**: Unprocessed 32-bit floating-point depth
- **System-Wide Camera Access**: Advanced camera controls
- **Persistent AR Sessions**: Multi-app AR integration

### 🔧 Developer Features
- **Advanced Diagnostics**: Comprehensive logging and system monitoring
- **Debug Bridge**: Direct debugging access
- **System Logging**: Full system integration logs
- **Performance Monitoring**: Real-time performance metrics

## 🏗️ Building for TrollStore

### Prerequisites
1. **TrollStore 2.0+** installed on your iOS device
2. **macOS** with Xcode 15+
3. **CocoaPods** for dependency management
4. **iOS 17.6+** compatible device (iPhone 12 Pro+ or iPad Pro 2020+)

### Method 1: GitHub Actions (Recommended)

1. **Push to Repository**
   ```bash
   git add .
   git commit -m "Build for TrollStore"
   git push origin main
   ```

2. **Trigger Build**
   - Go to Actions tab in GitHub
   - Select "Build Unsigned IPA for TrollStore" workflow
   - Click "Run workflow" or wait for automatic trigger
   - Choose build type (Release/Debug)

3. **Download IPA**
   - Wait for build completion
   - Download from Actions artifacts or GitHub Releases

### Method 2: Local Build Script

1. **Run Build Script**
   ```bash
   ./scripts/build-trollstore.sh [Release|Debug] [build-number]
   ```

2. **Example Commands**
   ```bash
   # Default release build
   ./scripts/build-trollstore.sh

   # Debug build with custom number
   ./scripts/build-trollstore.sh Debug 1001

   # Release build with timestamp
   ./scripts/build-trollstore.sh Release
   ```

3. **Find IPA**
   - IPA created in project root: `DepthCamera-TrollStore-[build-number].ipa`
   - Build info: `build-info-[build-number].json`

### Method 3: Manual Xcode Build

1. **Install Dependencies**
   ```bash
   cd DepthCamera
   pod install
   ```

2. **Configure Build Settings**
   ```bash
   # Set build number
   agvtool new-marketing-version 1.1
   agvtool new-version -all 1001
   ```

3. **Build Command**
   ```bash
   xcodebuild \
     -workspace DepthCamera.xcworkspace \
     -scheme DepthCamera \
     -configuration Release \
     -destination generic/platform=iOS \
     -archivePath ./build/DepthCamera.xcarchive \
     archive \
     CODE_SIGN_IDENTITY="" \
     CODE_SIGNING_REQUIRED=NO \
     ENTITLEMENTS_FILE="DepthCamera/DepthCamera-TrollStore.entitlements"
   ```

4. **Export IPA**
   ```bash
   # Create export options
   cat > Export.plist << EOF
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
       <key>method</key>
       <string>development</string>
       <key>signingStyle</key>
       <string>manual</string>
   </dict>
   </plist>
   EOF

   # Export
   xcodebuild \
     -exportArchive \
     -archivePath ./build/DepthCamera.xcarchive \
     -exportPath ./build \
     -exportOptionsPlist Export.plist
   ```

## 📱 Installation via TrollStore

### Method 1: Direct Installation
1. Transfer IPA to iOS device (Files app, AirDrop, etc.)
2. Open TrollStore
3. Tap "Install" or "+" button
4. Select the IPA file
5. Install with enhanced entitlements

### Method 2: URL Scheme
```bash
# Install via TrollStore URL scheme
trollstore://install?url=https://example.com/DepthCamera-TrollStore.ipa
```

### Method 3: TrollHelper (Advanced)
1. Place IPA in TrollStore directory
2. Use TrollHelper for automated installation
3. Configure installation options

## ⚙️ Configuration and Usage

### First Launch
1. **Grant Permissions** - When prompted, allow all requested permissions
2. **Camera Access** - Grant full camera and LiDAR access
3. **File Access** - Allow file system access for enhanced features
4. **Microphone** - Optional, for enhanced depth capture features

### Enhanced Features Usage

#### Unlimited File System Access
```swift
// Save to custom locations (TrollStore only)
saveDepthDataToCustomPath(depthData, "/var/mobile/CustomDepthMaps/")
```

#### Enhanced Memory Management
```swift
// Enable unlimited memory for large depth maps
enableUnlimitedMemoryMode()
```

#### Background Processing
```swift
// Continuous background capture
enableBackgroundDepthCapture()
```

#### Advanced Diagnostics
```swift
// Enable comprehensive logging
enableEnhancedDiagnostics()
```

### File Locations (TrollStore Enhanced)
- **Depth Maps**: `/var/mobile/Containers/Data/Application/[UUID]/Documents/DepthMaps/`
- **Custom Saves**: `/Documents/DepthMaps/` (unrestricted)
- **Enhanced Logs**: `/Documents/EnhancedLogs/`
- **Temporary Cache**: `/var/tmp/DepthCache/`

## 🔍 Verification

### Check TrollStore Features
1. Open app
2. Go to Settings → Advanced
3. Verify "TrollStore Enhanced" status
4. Check enabled features list

### Test Enhanced Capabilities
1. **Unlimited File Access**: Try saving to different locations
2. **Enhanced Memory**: Capture very large depth maps
3. **Background Mode**: Test background capture
4. **System Integration**: Check system-wide access

### Log Files
- **Standard Logs**: Console app
- **Enhanced Logs**: `/Documents/EnhancedLogs/trollstore_enhanced.log`
- **System Diagnostics**: Settings → Privacy → Analytics & Improvements

## 🛠️ Troubleshooting

### Build Issues
```bash
# Clean build
./scripts/build-trollstore.sh

# Clear CocoaPods cache
pod cache clean --all
pod install --repo-update

# Check Xcode version
xcodebuild -version
```

### Installation Issues
1. **IPA Corrupted**: Rebuild with latest source
2. **TrollStore Version**: Update to latest TrollStore
3. **Device Compatibility**: Verify iOS version and device support
4. **Permission Issues**: Check TrollStore permissions

### Runtime Issues
1. **Check Logs**: Review enhanced logs
2. **Reset Settings**: Clear app data and reconfigure
3. **TrollStore Reinstall**: Reinstall TrollStore and app
4. **System Update**: Ensure iOS is up to date

## 🔐 Security Notes

### TrollStore Entitlements
- **Unrestricted Access**: Full file system and system access
- **No Sandbox**: Direct system integration
- **Enhanced Capabilities**: Advanced camera and ARKit features
- **System Logging**: Comprehensive system access

### Privacy Considerations
- **Data Location**: App can access any file location
- **System Integration**: Enhanced system monitoring
- **Network Access**: Unrestricted network capabilities
- **Permissions**: Grant all requested permissions for full functionality

### Best Practices
1. **Install from Trusted Sources**: Only use IPAs from trusted repositories
2. **Review Permissions**: Understand requested permissions
3. **Monitor Usage**: Check enhanced logs regularly
4. **Update Regularly**: Keep app and TrollStore updated

## 📚 Advanced Usage

### Custom Entitlements
Edit `DepthCamera/DepthCamera-TrollStore.entitlements` for custom features:

```xml
<!-- Add custom entitlements -->
<key>com.apple.custom.entitlement</key>
<true/>
```

### Build Configuration
Customize build settings in `.github/workflows/trollstore-build.yml`:

```yaml
env:
  MARKETING_VERSION: '1.1'
  SCHEME_NAME: 'DepthCamera'
  # Add custom environment variables
```

### Feature Flags
Enable/disable features in `ARViewModel+TrollStore.swift`:

```swift
// Feature flags
private let enableUnlimitedFileSystem = true
private let enableEnhancedMemory = true
private let enableBackgroundProcessing = true
```

## 📄 License and Disclaimer

This TrollStore-enhanced version is for educational and research purposes. Users are responsible for:
- Compliance with local laws and regulations
- Proper use of enhanced system access
- Security of their devices and data
- Understanding the implications of TrollStore usage

## 🤝 Contributing

Contributions for TrollStore enhancements welcome:
- **Bug Reports**: Report TrollStore-specific issues
- **Feature Requests**: Suggest new enhanced capabilities
- **Entitlements**: Propose additional entitlements
- **Optimization**: Improve performance with TrollStore features

## 📞 Support

For TrollStore-specific issues:
1. Check [TrollStore Documentation](https://github.com/opa334/trollstore)
2. Review build logs and error messages
3. Verify TrollStore version compatibility
4. Check device compatibility list

---

**⚠️ Important**: This build specifically requires TrollStore and will not function with standard sideloading methods or the App Store. Ensure you have TrollStore properly installed before proceeding.