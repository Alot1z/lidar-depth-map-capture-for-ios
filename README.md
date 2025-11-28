# LiDAR Depth Map Capture for iOS

Professional LiDAR depth capture app with maximum precision and TrollStore enhancements.

App Store: [https://apps.apple.com/us/app/depth-camera-raw/id6557075309](https://apps.apple.com/us/app/depth-camera-raw/id6557075309)

## 📱 Features

- **Real-time LiDAR depth capture** with ARKit integration
- **32-bit floating-point TIFF export** - preserves original precision
- **Interactive depth measurement tools** - tap to measure depth values
- **Confidence map visualization** - see capture quality indicators
- **Thumbnail generation and file management**
- **TrollStore enhanced version** with maximum system access
- **Background processing** for large depth maps (TrollStore only)
- **Unlimited file system access** (TrollStore only)

## How it works

The LiDAR scanner on supported iPhone and iPad models provides depth information for each pixel in the captured image. However, when using the standard iOS libraries, this depth information is typically scaled down to 8-bit, losing much of the original precision.

This app bypasses that limitation by directly accessing the depth data from the LiDAR scanner and saving it as a 32-bit floating-point TIFF image. Each pixel in the resulting TIFF image contains a floating-point value representing the distance from the camera to that point in the scene, in meters.

For example, if a point in the scene is 5 meters away from the camera, the corresponding pixel value in the TIFF image will be 5.0. Similarly, if a point is 30 centimeters away, the pixel value will be 0.3.

## 🚀 Build System

### Two Automated Workflows:

1. **`trollstore ipa build`** - Maximum entitlements, enhanced features
   - Unlimited file system access
   - Enhanced ARKit capabilities
   - Background processing
   - Maximum system integration

2. **`sideload ipa build`** - Standard sandbox, AltStore compatible
   - App Store sandbox compliance
   - Basic depth capture features
   - Compatible with AltStore, Sideloadly

### Project Structure:

```
lidar-depth-map-capture-for-ios/
├── DepthCamera/                    # App source code
│   ├── ARViewModel+TrollStore.swift
│   ├── DepthCamera-TrollStore.entitlements
│   └── ... (Swift files)
├── DepthCamera.xcodeproj/          # Xcode project
├── DepthCamera.xcworkspace/        # CocoaPods workspace
├── .github/workflows/              # GitHub Actions CI/CD
│   ├── trollstore-build.yml
│   └── sideload-build.yml
└── Podfile                         # Dependencies
```

## 📋 Requirements

- iOS 16.0+
- iPhone 12 Pro+ or iPad Pro 2020+ (LiDAR sensor)
- Xcode 15+ (for development)
- CocoaPods

## 🔧 Installation

### Option 1: TrollStore (Recommended)
1. Go to [GitHub Actions](https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions)
2. Select `trollstore ipa build` workflow
3. Download the IPA from artifacts
4. Install with TrollStore for maximum features

### Option 2: Standard Sideload
1. Go to [GitHub Actions](https://github.com/Alot1z/lidar-depth-map-capture-for-ios/actions)
2. Select `sideload ipa build` workflow
3. Download the IPA from artifacts
4. Install with AltStore, Sideloadly, or other tools

### Option 3: Development Build
```bash
# Clone and setup
git clone https://github.com/Alot1z/lidar-depth-map-capture-for-ios.git
cd lidar-depth-map-capture-for-ios
pod install

# Open in Xcode
open DepthCamera.xcworkspace
```

## Usage

1. Launch the app on your iPhone or iPad.
2. Point the camera at the scene you want to capture.
3. Tap the "Capture" button to capture a depth map.
4. The depth map will be saved to your device as a 32-bit floating-point TIFF image.

## Contributing

We welcome contributions to this project. If you find a bug or have a feature request, please open an issue on the GitHub repository. If you'd like to contribute code, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
