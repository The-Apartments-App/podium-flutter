#!/bin/bash

# Build the Flutter web app
flutter build web -t lib/main_production.dart

# Deploy the app to Firebase
firebase deploy --except functions
