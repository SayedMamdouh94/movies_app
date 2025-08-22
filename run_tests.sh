#!/bin/bash

echo "🧪 Running Movies App Tests"
echo "=========================="

echo ""
echo "📋 Running Unit Tests..."
flutter test test/unit/

echo ""
echo "🎨 Running Widget Tests..."
flutter test test/widget/

echo ""
echo "📱 Running Main Widget Test..."
flutter test test/widget_test.dart

echo ""
echo "🔗 Running Integration Tests..."
flutter test integration_test/

echo ""
echo "✅ All tests completed!"
