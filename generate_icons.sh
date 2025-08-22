#!/bin/bash

# Script to generate app icons for Movies App
# Make sure you have placed your app icon at: assets/images/app_icon.png

echo "🎬 Movies App - Icon Generator"
echo "=============================="

# Check if the icon file exists
if [ ! -f "assets/images/app_icon.png" ]; then
    echo "❌ Error: app_icon.png not found!"
    echo "Please place your 1024x1024 PNG icon at: assets/images/app_icon.png"
    echo ""
    echo "You can convert your existing SVG using:"
    echo "- Online tools like https://convertio.co/svg-png/"
    echo "- Graphics software (Photoshop, GIMP, Figma, etc.)"
    echo ""
    exit 1
fi

echo "✅ Found app icon file"
echo "📱 Generating launcher icons..."

# Install dependencies
flutter pub get

# Generate the icons
flutter pub run flutter_launcher_icons

echo ""
echo "🎉 Icon generation complete!"
echo "Your custom app icon is now ready."
echo ""
echo "To test your app with the new icon:"
echo "flutter run"
