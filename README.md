# PDF Fill & Sign - iOS App

A professional iOS application for filling and signing PDF documents, similar to Adobe Fill & Sign. Built with SwiftUI and PDFKit.

## Features

- **PDF Import**: Import PDF documents from Files app or iCloud
- **Text Annotation**: Add custom text anywhere on the PDF
- **Signature Drawing**: Draw and save your signature with your finger
- **Checkmarks**: Add checkmarks to forms and documents
- **Circle Annotations**: Highlight areas with circles
- **Export & Share**: Save edited PDFs or share via any app
- **Multi-page Support**: Work with multi-page PDF documents
- **Intuitive UI**: Clean, modern interface following iOS design guidelines

## Requirements

- **macOS**: macOS 13.0 or later with Xcode installed
- **Xcode**: Version 15.0 or later
- **iOS Deployment Target**: iOS 15.0 or later
- **Apple Developer Account**: Required for App Store submission ($99/year)

## Project Structure

```
PDFillSign/
├── PDFillSign.xcodeproj/        # Xcode project file
│   └── project.pbxproj
└── PDFillSign/                  # Source code
    ├── PDFillSignApp.swift      # App entry point
    ├── ContentView.swift        # Main view with welcome screen
    ├── Info.plist               # App configuration
    ├── Assets.xcassets/         # App icons and images
    │   └── AppIcon.appiconset/
    ├── Models/                  # Data models
    │   ├── DocumentManager.swift    # PDF document management
    │   └── AnnotationModel.swift    # Annotation tools model
    └── Views/                   # UI components
        ├── PDFEditorView.swift      # Main PDF editor
        ├── ToolbarView.swift        # Annotation toolbar
        ├── SignatureView.swift      # Signature drawing
        ├── TextInputView.swift      # Text input dialog
        ├── DocumentPicker.swift     # File import
        └── SaveDocumentView.swift   # Export/share functionality
```

## Setup Instructions

### 1. Open Project in Xcode

1. Open **Xcode** on your Mac
2. Navigate to `File > Open`
3. Select the `PDFillSign.xcodeproj` file
4. The project will open in Xcode

### 2. Configure Signing & Capabilities

1. In Xcode, select the **PDFillSign** project in the navigator
2. Select the **PDFillSign** target
3. Go to **Signing & Capabilities** tab
4. Under **Signing**, select your **Team** (Apple Developer Account)
5. Xcode will automatically generate a bundle identifier (or you can customize it)
6. Ensure **Automatically manage signing** is checked

### 3. Add App Icons (Important for App Store)

The app currently has placeholder app icons. You need to add actual icons:

1. Create app icons in the following sizes:
   - 1024x1024 (App Store)
   - 180x180 (iPhone)
   - 120x120 (iPhone)
   - 167x167 (iPad)
   - 152x152 (iPad)

2. You can use tools like:
   - [App Icon Generator](https://appicon.co/)
   - [MakeAppIcon](https://makeappicon.com/)
   - Sketch, Figma, or Photoshop

3. In Xcode:
   - Open `Assets.xcassets`
   - Select `AppIcon`
   - Drag and drop your icon files into the appropriate slots

### 4. Update Bundle Identifier (Optional)

1. In Xcode, go to project settings
2. Change `PRODUCT_BUNDLE_IDENTIFIER` from `com.pdffillsign.app` to your own unique identifier
3. Format: `com.yourcompany.pdffillsign`

## Testing the App

### Run on Simulator

1. In Xcode, select a simulator from the device dropdown (e.g., "iPhone 15 Pro")
2. Click the **Play** button (⌘R) or select `Product > Run`
3. The app will launch in the iOS Simulator

### Run on Physical Device

1. Connect your iPhone or iPad via USB
2. Select your device from the device dropdown
3. Click the **Play** button (⌘R)
4. If prompted, trust the developer certificate on your device
5. The app will install and launch on your device

## App Store Submission

### Before Submission

1. **Privacy Policy**: Create a privacy policy (required by App Store)
   - Host it on a public URL
   - Explain data collection (this app stores PDFs locally only)

2. **App Preview**: Create screenshots and app preview videos
   - Required sizes: 6.7", 6.5", 5.5" for iPhone
   - Required sizes: 12.9" for iPad (if supporting iPad)

3. **App Description**: Write compelling app description and keywords

4. **Testing**: Thoroughly test all features
   - Import PDFs
   - Add text annotations
   - Draw signatures
   - Add checkmarks and circles
   - Export and share PDFs

### Archive and Upload

1. **Create Archive**:
   - In Xcode, select `Product > Archive`
   - Wait for the archive to complete
   - The Organizer window will open

2. **Validate App**:
   - Select your archive
   - Click **Validate App**
   - Fix any validation errors

3. **Distribute App**:
   - Click **Distribute App**
   - Select **App Store Connect**
   - Upload the app
   - Wait for processing (can take 30-60 minutes)

4. **App Store Connect**:
   - Go to [App Store Connect](https://appstoreconnect.apple.com/)
   - Create a new app listing
   - Fill in all required metadata:
     - App name
     - Subtitle
     - Description
     - Keywords
     - Screenshots
     - Privacy policy URL
     - Support URL
   - Select the uploaded build
   - Submit for review

### Review Process

- Initial review typically takes 1-3 days
- Apple will test the app for compliance
- You'll receive approval or rejection via email
- If rejected, fix issues and resubmit

## Customization

### Change App Name

Edit `Info.plist`:
```xml
<key>CFBundleDisplayName</key>
<string>Your App Name</string>
```

### Change Color Scheme

Modify colors in SwiftUI views (e.g., `.blue` to `.purple`)

### Add More Annotation Tools

1. Add new case to `AnnotationType` enum in `AnnotationModel.swift`
2. Create annotation method in `AnnotationModel`
3. Add button in `ToolbarView.swift`
4. Handle tap in `PDFEditorView.swift`

## Troubleshooting

### Build Fails

- Ensure Xcode is up to date
- Clean build folder: `Product > Clean Build Folder`
- Restart Xcode

### Signing Error

- Verify Apple Developer Account is active
- Check Team selection in Signing & Capabilities
- Ensure bundle identifier is unique

### App Crashes

- Check device logs in Xcode: `Window > Devices and Simulators`
- Look for error messages in console

## Technical Details

### Frameworks Used

- **SwiftUI**: Modern UI framework
- **PDFKit**: PDF rendering and annotation
- **UniformTypeIdentifiers**: File type handling

### Minimum iOS Version

iOS 15.0+ (can be changed in project settings)

### Supported Devices

- iPhone (all models with iOS 15+)
- iPad (all models with iOS 15+)

## License

This project is provided as-is for development and App Store submission.

## Support

For issues or questions:
1. Check Apple Developer documentation
2. Visit [Apple Developer Forums](https://developer.apple.com/forums/)
3. Review [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

## Next Steps

1. Open project in Xcode
2. Add app icons
3. Test thoroughly on device
4. Create App Store Connect listing
5. Submit for review
6. Publish to App Store

Good luck with your app submission!
