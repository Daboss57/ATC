# ATC Live - Air Traffic Control Radio App

A native iOS app for streaming live air traffic control radio from airports worldwide.

## Phase 1 - Core Features ✅

### Implemented
- ✅ Audio streaming engine with AVPlayer
- ✅ Clean SwiftUI interface with gradient design
- ✅ List of major airport stations (JFK, LAX, ORD, ATL, SFO)
- ✅ Play/Pause/Stop controls
- ✅ Now Playing bar with station info
- ✅ Visual feedback (animated audio visualizer)
- ✅ Background audio support
- ✅ Audio session management
- ✅ Error handling and user feedback
- ✅ Interruption handling (calls, other apps)

### Features
- **Live Audio Streaming**: Listen to real-time ATC communications
- **Multiple Stations**: Pre-loaded with 5 major US airports
- **Beautiful UI**: Modern SwiftUI design with glassmorphism effects
- **Background Playback**: Continue listening when app is in background
- **Visual Feedback**: Animated waveform visualization when playing

## Tech Stack
- **Language**: Swift 5.9+
- **Framework**: SwiftUI
- **Audio**: AVFoundation (AVPlayer)
- **Minimum iOS**: 15.0+

## Project Structure
```
ATC/
├── ATC/
│   ├── ATCApp.swift           # App entry point
│   ├── Models/
│   │   └── Station.swift      # Station data model
│   ├── Services/
│   │   └── AudioStreamManager.swift  # Audio streaming logic
│   ├── Views/
│   │   └── ContentView.swift  # Main UI
│   └── Info.plist            # App configuration
└── README.md
```

## How to Run
1. Open `ATC.xcodeproj` in Xcode 15+
2. Select a simulator or connected device
3. Build and run (⌘R)
4. Tap any station to start streaming
5. Use the Now Playing bar to control playback

## Audio Stream URLs
Currently using LiveATC.net streams. Note: These are example URLs and may need updating with actual working endpoints.

## Next Steps (Phase 2)
- 🗺️ Map integration with airport locations
- 📍 Location-based airport discovery
- 🌍 Expanded station database
- 🎨 Custom app icon and splash screen

## Requirements
- Xcode 15.0+
- iOS 15.0+
- Internet connection for streaming

## Notes
- Audio streams require network connection
- Background audio is supported
- App Transport Security is configured for HTTP streams
- Handles audio interruptions (calls, Siri, etc.)

---
**Phase 1 Complete** - Ready for testing and iteration! 🎉
