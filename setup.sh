#!/bin/bash

# ATC iOS Project Setup Script
# Run this on your MacBook after transferring the files

echo "🚀 Setting up ATC iOS Project..."

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found. Please install Xcode from the App Store."
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "📁 Current directory: $SCRIPT_DIR"

# Create the Xcode project using command line
echo "📦 Creating Xcode project..."

# Create project directory structure
mkdir -p "ATC.xcodeproj"

# Create the Package.swift to help with project generation
cat > Package.swift << 'EOF'
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ATC",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "ATC", targets: ["ATC"])
    ],
    targets: [
        .target(name: "ATC", path: "ATC")
    ]
)
EOF

echo "✅ Package.swift created"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  MANUAL SETUP REQUIRED IN XCODE:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Since Xcode project files are complex, please follow these steps:"
echo ""
echo "1️⃣  Open Xcode"
echo "2️⃣  Select: File → New → Project"
echo "3️⃣  Choose: iOS → App"
echo "4️⃣  Settings:"
echo "     • Product Name: ATC"
echo "     • Team: (Your team)"
echo "     • Organization Identifier: com.yourcompany"
echo "     • Interface: SwiftUI"
echo "     • Language: Swift"
echo "     • Storage: None"
echo "     • Uncheck: Include Tests"
echo "5️⃣  Save to: $SCRIPT_DIR"
echo "6️⃣  Delete the generated files: ContentView.swift, ATCApp.swift"
echo "7️⃣  Drag and drop these folders into the project navigator:"
echo "     • ATC/Models"
echo "     • ATC/Services"
echo "     • ATC/Views"
echo "     • ATC/ATCApp.swift"
echo "8️⃣  Select 'Copy items if needed'"
echo "9️⃣  In Info.plist, add:"
echo "     • Key: UIBackgroundModes, Value: audio"
echo "     • Key: NSAppTransportSecurity → NSAllowsArbitraryLoads = YES"
echo "🔟 Build and Run! (⌘R)"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Or use the EASY METHOD below! 👇"
echo ""
