#!/bin/bash

# Build the Flutter web app
flutter build web -t lib/main.dart

# Deploy the app to Firebase
firebase deploy --except functions
