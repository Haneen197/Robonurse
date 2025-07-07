# Firebase Setup Guide for RoboNurse

This guide will help you set up Firebase for your RoboNurse Flutter application.

## Prerequisites

1. A Google account
2. Flutter SDK installed
3. Android Studio or VS Code with Flutter extensions

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "robonurse-app")
4. Choose whether to enable Google Analytics (recommended)
5. Click "Create project"

## Step 2: Enable Authentication

1. In your Firebase project console, go to "Authentication" in the left s   idebar
2. Click "Get started"
3. Go to the "Sign-in method" tab
4. Enable "Email/Password" authentication:
   - Click on "Email/Password"
   - Toggle the "Enable" switch
   - Click "Save"

## Step 3: Set up Firestore Database

1. In your Firebase project console, go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" for development (you can change security rules later)
4. Select a location for your database (choose the closest to your users)
5. Click "Done"

## Step 4: Configure Security Rules for Firestore

1. In Firestore Database, go to the "Rules" tab
2. Replace the default rules with the following:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow authenticated users to read user data (for role-based access)
    match /users/{userId} {
      allow read: if request.auth != null;
    }
  }
}
```

3. Click "Publish"

## Step 5: Add Firebase to Your Flutter App

### For Android:

1. In your Firebase project console, click the gear icon next to "Project Overview"
2. Select "Project settings"
3. Scroll down to "Your apps" section
4. Click the Android icon to add an Android app
5. Enter your Android package name (found in `android/app/build.gradle`):
   ```
   com.example.robonurse_new
   ```
6. Enter app nickname: "RoboNurse Android"
7. Click "Register app"
8. Download the `google-services.json` file
9. Place the `google-services.json` file in the `android/app/` directory of your Flutter project

### For iOS:

1. In the same project settings page, click the iOS icon
2. Enter your iOS bundle ID (found in `ios/Runner/Info.plist`):
   ```
   com.example.robonurseNew
   ```
3. Enter app nickname: "RoboNurse iOS"
4. Click "Register app"
5. Download the `GoogleService-Info.plist` file
6. Place the `GoogleService-Info.plist` file in the `ios/Runner/` directory of your Flutter project

## Step 6: Update Android Configuration

1. Open `android/build.gradle` and add the following to the `buildscript` dependencies:

```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

2. Open `android/app/build.gradle` and add the following at the bottom:

```gradle
// Add this line at the bottom
apply plugin: 'com.google.gms.google-services'
```

## Step 7: Update iOS Configuration

1. Open `ios/Runner/Info.plist` and add the following inside the `<dict>` tag:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

Replace `YOUR_REVERSED_CLIENT_ID` with the value from your `GoogleService-Info.plist` file.

## Step 8: Install Dependencies

Run the following command in your project root:

```bash
flutter pub get
```

## Step 9: Test Your Setup

1. Run your app:
   ```bash
   flutter run
   ```

2. Try to create a new account using the signup form
3. Check your Firebase console to see if the user was created in Authentication
4. Check Firestore Database to see if the user data was stored

## Troubleshooting

### Common Issues:

1. **"No Firebase App '[DEFAULT]' has been created"**
   - Make sure you've placed the configuration files in the correct directories
   - Ensure Firebase is properly initialized in your `main.dart`

2. **"Permission denied" errors in Firestore**
   - Check your Firestore security rules
   - Make sure you're in test mode or have proper rules set up

3. **Build errors on Android**
   - Make sure `google-services.json` is in `android/app/`
   - Verify the package name matches between your app and Firebase console

4. **Build errors on iOS**
   - Make sure `GoogleService-Info.plist` is in `ios/Runner/`
   - Verify the bundle ID matches between your app and Firebase console

## Security Considerations

For production:

1. Update Firestore security rules to be more restrictive
2. Enable additional authentication methods as needed
3. Set up proper user roles and permissions
4. Consider implementing email verification
5. Set up proper error handling and logging

## Next Steps

After setting up Firebase:

1. Implement email verification
2. Add password reset functionality
3. Implement role-based access control
4. Add user profile management
5. Set up push notifications
6. Implement data backup and recovery

For more information, visit the [Firebase Flutter documentation](https://firebase.flutter.dev/). 