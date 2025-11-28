#!/bin/bash

# Build Script for TrollStore Unsigned IPA
# Enhanced LiDAR Depth Map Capture App with Maximum Entitlements

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# App configuration
APP_NAME="DepthCamera"
SCHEME_NAME="DepthCamera"
WORKSPACE_NAME="DepthCamera.xcworkspace"
BUNDLE_ID="dev.iori.depthcamera0"
MARKETING_VERSION="1.1"
TROLLSTORE_ENTITLEMENTS="DepthCamera/DepthCamera-TrollStore.entitlements"

# Build configuration
BUILD_TYPE="${1:-Release}"  # Default to Release, can be overridden with Debug
BUILD_NUMBER="${2:-$(date +%s)}"  # Default to timestamp, can be overridden

echo -e "${BLUE}🚀 Building TrollStore-Enhanced DepthCamera App${NC}"
echo -e "${YELLOW}Configuration: $BUILD_TYPE | Build Number: $BUILD_NUMBER${NC}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if running in correct directory
check_directory() {
    if [[ ! -d "DepthCamera" ]]; then
        print_error "DepthCamera directory not found. Please run from project root."
        exit 1
    fi

    if [[ ! -f "DepthCamera/$WORKSPACE_NAME" ]]; then
        print_error "Workspace file not found: DepthCamera/$WORKSPACE_NAME"
        exit 1
    fi

    if [[ ! -f "$TROLLSTORE_ENTITLEMENTS" ]]; then
        print_error "TrollStore entitlements not found: $TROLLSTORE_ENTITLEMENTS"
        exit 1
    fi

    print_status "✅ Directory structure validated"
}

# Function to install dependencies
install_dependencies() {
    print_status "📦 Installing dependencies..."

    cd DepthCamera

    # Check if CocoaPods is installed
    if ! command -v pod &> /dev/null; then
        print_error "CocoaPods not found. Installing..."
        sudo gem install cocoapods
    fi

    # Install pods
    pod install --repo-update

    # Verify pods installation
    if [[ ! -f "$WORKSPACE_NAME" ]]; then
        print_error "Workspace not created after pod install"
        exit 1
    fi

    print_status "✅ Dependencies installed successfully"

    cd ..
}

# Function to clean previous builds
clean_builds() {
    print_status "🧹 Cleaning previous builds..."

    cd DepthCamera

    # Clean Xcode build cache
    if [[ -d "build" ]]; then
        rm -rf build
        print_status "Cleaned build directory"
    fi

    # Clean derived data (optional - speeds up initial builds)
    # xcodebuild clean -workspace "$WORKSPACE_NAME" -scheme "$SCHEME_NAME"

    print_status "✅ Build environment cleaned"

    cd ..
}

# Function to configure build settings
configure_build() {
    print_status "⚙️ Configuring build settings..."

    cd DepthCamera

    # Set build number
    agvtool new-marketing-version "$MARKETING_VERSION"
    agvtool new-version -all "$BUILD_NUMBER"

    print_status "Version configured: $MARKETING_VERSION ($BUILD_NUMBER)"

    # Validate TrollStore entitlements
    if [[ -f "$TROLLSTORE_ENTITLEMENTS" ]]; then
        print_status "✅ TrollStore entitlements found and validated"

        # Show entitlements summary
        echo -e "${BLUE}Entitlements Summary:${NC}"
        plutil -p "$TROLLSTORE_ENTITLEMENTS" | grep -E "(key|string)" | head -10
        echo "   ... and more TrollStore enhancements"
    else
        print_error "TrollStore entitlements file not found"
        exit 1
    fi

    cd ..
}

# Function to build the app
build_app() {
    print_status "🔨 Building app for TrollStore..."

    cd DepthCamera

    # Create build directory
    mkdir -p build

    # Build without code signing for TrollStore
    echo -e "${BLUE}Building $BUILD_TYPE configuration...${NC}"

    xcodebuild \
        -workspace "$WORKSPACE_NAME" \
        -scheme "$SCHEME_NAME" \
        -configuration "$BUILD_TYPE" \
        -destination "generic/platform=iOS" \
        -archivePath "build/$APP_NAME-TrollStore.xcarchive" \
        archive \
        CODE_SIGN_IDENTITY="" \
        CODE_SIGNING_REQUIRED=NO \
        CODE_SIGNING_ALLOWED=NO \
        DEVELOPMENT_TEAM="" \
        PROVISIONING_PROFILE_SPECIFIER="" \
        ENTITLEMENTS_FILE="$TROLLSTORE_ENTITLEMENTS" \
        OTHER_CODE_SIGN_FLAGS="--keychain /dev/null" \
        ENABLE_BITCODE=NO

    if [[ $? -eq 0 ]]; then
        print_status "✅ App built successfully"
    else
        print_error "❌ Build failed"
        exit 1
    fi

    cd ..
}

# Function to export unsigned IPA
export_ipa() {
    print_status "📦 Exporting unsigned IPA..."

    cd DepthCamera

    # Create export options for unsigned IPA
    cat > build/TrollStore-Export.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>signingStyle</key>
    <string>manual</string>
    <key>codeSignIdentity</key>
    <string></string>
    <key>provisioningProfiles</key>
    <dict>
    </dict>
    <key>stripSwiftSymbols</key>
    <false/>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <false/>
    <key>compileBitcode</key>
    <false/>
    <key>thinning</key>
    <string>&lt;none&gt;</string>
</dict>
</plist>
EOF

    # Export the archive
    xcodebuild \
        -exportArchive \
        -archivePath "build/$APP_NAME-TrollStore.xcarchive" \
        -exportPath "build/TrollStore-Export" \
        -exportOptionsPlist "build/TrollStore-Export.plist" \
        -allowProvisioningUpdates

    if [[ $? -eq 0 ]]; then
        print_status "✅ Archive exported successfully"
    else
        print_error "❌ Export failed"
        exit 1
    fi

    cd ..
}

# Function to create IPA package
create_ipa() {
    print_status "📱 Creating IPA package..."

    cd DepthCamera

    # Find the .app file in the exported directory
    APP_PATH=$(find build/TrollStore-Export -name "*.app" -type d | head -n 1)

    if [[ -n "$APP_PATH" ]]; then
        print_status "Found app bundle: $(basename $APP_PATH)"

        # Create IPA structure
        mkdir -p build/Payload
        cp -r "$APP_PATH" build/Payload/

        # Create IPA file
        IPA_NAME="$APP_NAME-TrollStore-$BUILD_NUMBER.ipa"
        cd build
        zip -r "$IPA_NAME" Payload/
        cd ..

        # Clean up Payload directory
        rm -rf build/Payload

        # Verify IPA
        if [[ -f "build/$IPA_NAME" ]]; then
            IPA_SIZE=$(du -h "build/$IPA_NAME" | cut -f1)
            print_status "✅ IPA created successfully: $IPA_NAME ($IPA_SIZE)"

            # Move to root directory
            mv "build/$IPA_NAME" "../"
            print_status "📁 IPA moved to project root: $IPA_NAME"
        else
            print_error "❌ IPA file not created"
            exit 1
        fi
    else
        print_error "❌ App bundle not found in exported directory"
        exit 1
    fi

    cd ..
}

# Function to validate IPA
validate_ipa() {
    print_status "🔍 Validating IPA..."

    IPA_NAME="$APP_NAME-TrollStore-$BUILD_NUMBER.ipa"

    if [[ ! -f "$IPA_NAME" ]]; then
        print_error "❌ IPA file not found: $IPA_NAME"
        exit 1
    fi

    # Extract IPA for validation
    mkdir -p temp_validation
    cd temp_validation
    unzip -q "../$IPA_NAME"

    # Validate app structure
    APP_PATH=$(find Payload -name "*.app" -type d | head -n 1)
    if [[ -n "$APP_PATH" ]]; then
        print_status "✅ App bundle structure validated"

        # Check key files
        KEY_FILES=("Info.plist" "$APP_NAME")
        for file in "${KEY_FILES[@]}"; do
            if [[ -f "$APP_PATH/$file" ]]; then
                print_status "✅ Found required file: $file"
            else
                print_warning "⚠️ Missing file: $file"
            fi
        done

        # Check bundle identifier
        BUNDLE_ID_CHECK=$(/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" "$APP_PATH/Info.plist" 2>/dev/null || echo "Unknown")
        print_status "Bundle ID: $BUNDLE_ID_CHECK"

    else
        print_error "❌ Invalid IPA structure"
        cd ..
        rm -rf temp_validation
        exit 1
    fi

    cd ..
    rm -rf temp_validation

    print_status "✅ IPA validation completed"
}

# Function to generate build information
generate_build_info() {
    print_status "📋 Generating build information..."

    IPA_NAME="$APP_NAME-TrollStore-$BUILD_NUMBER.ipa"
    IPA_SIZE=$(du -h "$IPA_NAME" | cut -f1)

    cat > "build-info-$BUILD_NUMBER.json" << EOF
{
    "app_name": "$APP_NAME",
    "bundle_identifier": "$BUNDLE_ID",
    "marketing_version": "$MARKETING_VERSION",
    "build_number": "$BUILD_NUMBER",
    "build_type": "$BUILD_TYPE",
    "trollstore_optimized": true,
    "entitlements_file": "$TROLLSTORE_ENTITLEMENTS",
    "ipa_file": "$IPA_NAME",
    "ipa_size": "$IPA_SIZE",
    "build_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
    "git_commit": "$(git rev-parse HEAD 2>/dev/null || echo 'Unknown')",
    "git_branch": "$(git branch --show-current 2>/dev/null || echo 'Unknown')",
    "xcode_version": "$(xcodebuild -version | head -n 1)",
    "enhanced_features": [
        "Unlimited File System Access",
        "Unrestricted Memory Management",
        "Enhanced ARKit Capabilities",
        "Background Processing",
        "System-Level Integration",
        "Advanced Diagnostics",
        "No Sandbox Restrictions"
    ]
}
EOF

    print_status "✅ Build information generated: build-info-$BUILD_NUMBER.json"
}

# Function to display final summary
display_summary() {
    IPA_NAME="$APP_NAME-TrollStore-$BUILD_NUMBER.ipa"
    IPA_SIZE=$(du -h "$IPA_NAME" | cut -f1)

    echo ""
    echo -e "${GREEN}🎉 TrollStore Build Completed Successfully!${NC}"
    echo ""
    echo -e "${BLUE}📱 Build Information:${NC}"
    echo -e "   • App: $APP_NAME"
    echo -e "   • Version: $MARKETING_VERSION ($BUILD_NUMBER)"
    echo -e "   • Bundle ID: $BUNDLE_ID"
    echo -e "   • Build Type: $BUILD_TYPE"
    echo -e "   • IPA File: $IPA_NAME"
    echo -e "   • IPA Size: $IPA_SIZE"
    echo ""
    echo -e "${BLUE}🚀 TrollStore Enhancements:${NC}"
    echo -e "   • ✅ Unlimited File System Access"
    echo -e "   • ✅ Enhanced Memory Management"
    echo -e "   • ✅ ARKit Unlimited Depth Capture"
    echo -e "   • ✅ Background Processing"
    echo -e "   • ✅ System Integration"
    echo -e "   • ✅ Advanced Diagnostics"
    echo -e "   • ✅ No Sandbox Restrictions"
    echo ""
    echo -e "${YELLOW}📋 Installation Instructions:${NC}"
    echo -e "   1. Transfer $IPA_NAME to your iOS device"
    echo -e "   2. Open TrollStore"
    echo -e "   3. Install the IPA"
    echo -e "   4. Grant permissions when prompted"
    echo ""
    echo -e "${GREEN}🔐 Enhanced Security Notes:${NC}"
    echo -e "   • This build requires TrollStore to function"
    echo -e "   • Standard sideloading methods will not work"
    echo -e "   • App has enhanced system access via TrollStore"
    echo ""
}

# Main build process
main() {
    echo -e "${BLUE}🚀 Starting TrollStore Build Process...${NC}"

    check_directory
    install_dependencies
    clean_builds
    configure_build
    build_app
    export_ipa
    create_ipa
    validate_ipa
    generate_build_info
    display_summary

    echo -e "${GREEN}✅ Build process completed successfully!${NC}"
}

# Run main function
main "$@"