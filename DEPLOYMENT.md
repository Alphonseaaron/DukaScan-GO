# DukaScanGo Deployment Guide

This document provides instructions for deploying the DukaScanGo application.

## Firebase Setup

1.  Create a new Firebase project in the [Firebase console](https://console.firebase.google.com/).
2.  Add an Android and iOS app to your Firebase project.
3.  Download the `google-services.json` file for Android and the `GoogleService-Info.plist` file for iOS and place them in the appropriate directories in the project.
4.  Enable Firebase Authentication, Firestore, and Cloud Functions in the Firebase console.
5.  Configure Firebase Hosting for the web components of the application.

## Backend Deployment

1.  Deploy the Firestore security rules using the Firebase CLI:

    ```
    firebase deploy --only firestore:rules
    ```

2.  Deploy the Cloud Functions using the Firebase CLI:

    ```
    firebase deploy --only functions
    ```

## Frontend Deployment

### Web

1.  Build the web app for production:

    ```
    flutter build web
    ```

2.  Deploy the web app to Firebase Hosting:

    ```
    firebase deploy --only hosting
    ```

### Mobile

1.  Build the Android app for release:

    ```
    flutter build apk --release
    ```

2.  Build the iOS app for release:

    ```
    flutter build ios --release
    ```

3.  Deploy the Android and iOS apps to the Google Play Store and Apple App Store, respectively.
