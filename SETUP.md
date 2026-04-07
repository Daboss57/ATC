# ATC iOS App - Setup Instructions

## 🎯 Quick Setup on MacBook

The Xcode project file needs to be created properly on macOS. Here's the **easiest way**:

### **Method 1: Create New Project (RECOMMENDED)** ⭐

1. **Open Xcode** on your MacBook
2. **File → New → Project**
3. Select **iOS → App**
4. Configure:
   - **Product Name**: `ATC`
   - **Interface**: `SwiftUI`
   - **Language**: `Swift`
   - **Storage**: `None`
   - Uncheck "Include Tests"
5. **Save it** in this folder (replace the broken ATC.xcodeproj)
6. In Xcode's **Project Navigator**, **delete** these auto-generated files:
   - `ATCApp.swift`
   - `ContentView.swift`
   - `Assets.xcassets` (optional)
7. **Drag and drop** from Finder into Xcode:
   - `ATC/ATCApp.swift`
   - `ATC/Models/` folder
   - `ATC/Services/` folder
   - `ATC/Views/` folder
8. When prompted, select **"Copy items if needed"**
9. **Configure Info.plist**:
   - Select your project in navigator → Target → Info tab
   - Add **Custom iOS Target Properties**:
     - `UIBackgroundModes` = `["audio"]`
   - Or manually edit Info.plist to add background audio mode
10. **Build & Run** (⌘R)

### **Method 2: Use Existing Files**

If you want to keep the folder structure as-is:

1. Open **Terminal** in this folder
2. Run: `chmod +x setup.sh && ./setup.sh`
3. Follow the instructions

---

## 📂 Your Source Files (Ready to Use!)

All these files are complete and working:

```
ATC/
├── ATCApp.swift              ✅ App entry point
├── Models/
│   └── Station.swift         ✅ Data models
├── Services/
│   └── AudioStreamManager.swift  ✅ Audio streaming
└── Views/
    └── ContentView.swift     ✅ Main UI
```

---

## 🔧 Important Settings

After creating the project, ensure these are set:

### **Info.plist Requirements:**
```xml
<key>UIBackgroundModes</key>
<array>
    <string>audio</string>
</array>

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### **Deployment Target:**
- iOS 15.0 or later

---

## 🚨 Troubleshooting

**Build errors?**
- Make sure all files are added to the target (check the Target Membership in file inspector)
- Clean build folder: Product → Clean Build Folder (⇧⌘K)

**Audio not playing?**
- Check Info.plist has background modes configured
- Verify internet connection
- Stream URLs may need updating (LiveATC.net streams)

**Can't find files?**
- Make sure you dragged them into the project navigator
- Files should show in the Xcode sidebar, not just Finder

---

## ✅ Once It Works

You should see:
- List of 5 airport stations
- Beautiful gradient UI
- Tap to play live ATC audio
- Now Playing bar at bottom
- Play/Pause/Stop controls

---

## 🎉 Next: Phase 2

Once Phase 1 is running, we can add:
- 🗺️ Map view with airport locations
- 📍 Location-based search
- ⭐ Favorites/bookmarks
- 🌍 More airports worldwide

Need help? Let me know! 🚀
