# To Do List App

This is a simple To Do List app built for the Android platform using the Flutter framework. The app allows users to add, update, and delete tasks, with data stored securely in **Google Cloud Firestore**.

## Features
- Add new tasks
- Update existing tasks
- Delete tasks
- Real-time task synchronization using Cloud Firestore
- Persistent task data

## Tech Stack
- **Frontend:** Flutter (Dart)
- **Backend:** Cloud Firestore (Firebase)

## Prerequisites
Before you can run this project, ensure you have the following:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>= 2.0.0)
- [Dart SDK](https://dart.dev/get-dart) 
- [Android Studio](https://developer.android.com/studio) / [Visual Studio Code](https://code.visualstudio.com/) (optional, but recommended)
- A [Firebase project](https://console.firebase.google.com/) set up for Cloud Firestore
- A physical Android device or emulator

## Setup Instructions

### Step 1: Clone the repository
```bash
git clone https://github.com/your-username/todo_list_app.git
cd todo_list_app
```
### Step 2: Install dependencies
Run the following command to install the necessary Flutter dependencies:
```bash
flutter pub get
```

### Step 3: Set up Firebase
1. **Create a Firebase project**:
   - Go to the [Firebase Console](https://console.firebase.google.com/).
2. **Enable Firestore Database**:
   - In the Firebase Console, navigate to **Firestore Database**.
   - Click **Create Database** and follow the instructions.
3. **Add an Android app to your Firebase project**:
   - In the Firebase Console, click on the **gear icon** next to Project Overview, then select **Project Settings**.
   - Under **Your apps**, click on the **Android icon** to register your Android app.
   - Follow the instructions to download the `google-services.json` file.
   - Place the `google-services.json` file in your Flutter project's `android/app/` directory.
4. **Configure Firebase dependencies**:
   - Ensure that your `pubspec.yaml` file includes the Firebase dependencies:
     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       cloud_firestore: ^4.7.0
       firebase_core: ^2.5.0
     ```

### Step 4: Configure Android settings
Make sure your `android/app/build.gradle` file contains the necessary Firebase configurations:
```groovy
dependencies {
    implementation platform('com.google.firebase:firebase-bom:32.2.3')
    implementation 'com.google.firebase:firebase-firestore'
}
```
Also, ensure that `android/build.gradle` has Google's Maven repository:
```groovy
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```
Finally, at the bottom of your `android/app/build.gradle` file, apply the Google Services plugin:
```groovy
apply plugin: 'com.google.gms.google-services'
```

### Step 5: Running the app
Run the app on an emulator or physical Android device using the following command:
```bash
flutter run
```

## How to Use
1. Launch the app on your Android device.
2. Add tasks by tapping the **+** button.
3. Edit or delete tasks by selecting them from the list.
4. Changes are automatically synced with Cloud Firestore.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```

You can replace `your-username` with your actual GitHub username or organization name. Adjust any other details as needed.
