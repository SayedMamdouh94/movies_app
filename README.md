# 🎬 Movies App

A modern, feature-rich Flutter application that showcases popular people from The Movie Database (TMDB) API. Built with clean architecture principles, offline-first design, and comprehensive testing.

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-lightgrey.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

</div>

## ✨ Features

### 🌟 Core Functionality

- **Browse Popular People**: Explore trending celebrities and movie personalities
- **Infinite Scroll**: Seamless pagination with automatic loading
- **Offline Support**: Cached data for uninterrupted browsing
- **Person Details**: Detailed information about celebrities
- **Image Gallery**: High-quality photos and profiles
- **Multi-language Support**: Localized content (English/Arabic)

### 🔧 Technical Features

- **Clean Architecture**: SOLID principles with proper separation of concerns
- **BLoC State Management**: Predictable state management with flutter_bloc
- **Offline-First Design**: Local caching with SQLite database
- **Responsive UI**: Adaptive layouts for different screen sizes
- **Custom App Icon**: Professional branding across all platforms
- **Comprehensive Testing**: Unit, Widget, and Integration tests

## 📱 Screenshots

| Home Screen                | Person Details            | Offline Mode          |
| -------------------------- | ------------------------- | --------------------- |
| _Popular people grid view_ | _Detailed celebrity info_ | _Cached data display_ |

## 🏗️ Architecture

### Clean Architecture Layers

```
lib/
├── core/                          # Shared utilities and services
│   ├── data/                      # Core data layer
│   ├── di/                        # Dependency injection
│   ├── helpers/                   # Utility functions
│   ├── localization/              # Multi-language support
│   ├── networking/                # API and network handling
│   ├── router/                    # App navigation
│   ├── services/                  # Core services
│   ├── style/                     # Theme and styling
│   └── widgets/                   # Reusable UI components
└── features/                      # Feature modules
    ├── popular_people/            # Main feature
    │   ├── data/                  # Data layer
    │   │   ├── apis/              # API services
    │   │   ├── datasources/       # Local & remote data sources
    │   │   ├── models/            # Data models
    │   │   └── repo/              # Repository implementation
    │   └── presentation/          # Presentation layer
    │       ├── cubit/             # State management
    │       └── ui/                # UI components
    │           ├── screens/       # Screen widgets
    │           └── widgets/       # Feature-specific widgets
    └── person_details/            # Person details feature
        ├── data/                  # Data layer
        └── presentation/          # Presentation layer
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**: 3.8.1 or higher
- **Dart**: 3.0 or higher
- **Android Studio** / **VS Code** with Flutter plugins
- **TMDB API Key**: Required for data fetching

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/YourUsername/movies_app.git
   cd movies_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Set up API key**

   - Get your API key from [TMDB](https://www.themoviedb.org/settings/api)
   - Add it to your secure storage (handled automatically on first run)

4. **Generate code**

   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

### Quick Commands

```bash
# Install dependencies
flutter pub get

# Generate code (models, APIs)
flutter packages pub run build_runner build

# Run tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate app icons
./generate_icons.sh

# Build for release
flutter build apk --release      # Android
flutter build ios --release      # iOS
flutter build web --release      # Web
```

## 🧪 Testing

The app includes comprehensive testing across all layers:

### Test Coverage

- **Unit Tests**: Business logic, repositories, services
- **Widget Tests**: UI components and interactions
- **Integration Tests**: End-to-end user flows
- **Coverage**: 90%+ code coverage

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test suites
flutter test test/unit/
flutter test test/widget/
flutter test integration_test/

# Run with coverage
flutter test --coverage
```

For detailed testing documentation, see [TESTING.md](TESTING.md).

## 📦 Key Dependencies

### Core Dependencies

```yaml
flutter_bloc: ^8.1.6 # State management
dio: ^5.8.0+1 # HTTP client
retrofit: ^4.4.2 # API client generation
get_it: ^8.0.3 # Dependency injection
sqflite: ^2.4.1 # Local database
flutter_secure_storage: ^9.2.4 # Secure key storage
```

### UI & Utils

```yaml
flutter_screenutil: ^5.9.3 # Responsive design
cached_network_image: ^3.4.1 # Image caching
shimmer: ^3.0.0 # Loading animations
flutter_svg: ^2.1.0 # SVG support
```

### Testing

```yaml
mocktail: ^1.0.4               # Mocking framework
bloc_test: ^10.0.0             # BLoC testing utilities
integration_test: sdk: flutter # Integration testing
patrol: ^3.13.1                # Enhanced testing
```

## 🌐 Features Deep Dive

### Offline-First Architecture

- **Local Caching**: SQLite database for persistent storage
- **Network Awareness**: Smart fallback to cached data
- **Sync Strategy**: Background sync when network available

### State Management

- **BLoC Pattern**: Predictable state management
- **State Types**: Loading, Loaded, Error, LoadingMore
- **Event Handling**: User actions and system events

### API Integration

- **TMDB API**: Real-time data from The Movie Database
- **Retrofit**: Type-safe API client generation
- **Error Handling**: Comprehensive error management
- **Rate Limiting**: Respectful API usage

### Localization

- **Multi-language**: English and Arabic support
- **RTL Support**: Right-to-left layout adaptation
- **Dynamic Switching**: Runtime language changes

## 🔧 Configuration

### Environment Setup

The app uses secure storage for sensitive configuration:

- API keys are stored securely
- Environment-specific configurations
- Debug/Release mode handling

### Custom App Icon

The app includes custom launcher icons for all platforms:

- **Android**: Adaptive icons with material design
- **iOS**: App Store compliant icons
- **Web**: Favicons and PWA icons
- **Desktop**: Platform-specific icons

## 🚀 Deployment

### Android

```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards

- Follow Flutter/Dart conventions
- Write tests for new features
- Update documentation
- Ensure code coverage > 85%

## 📝 Documentation

- [Testing Guide](TESTING.md) - Comprehensive testing documentation
- [Icon Setup](ICON_SETUP_INSTRUCTIONS.md) - Custom app icon configuration
- [API Documentation](https://developers.themoviedb.org/3) - TMDB API reference

## 🔐 Security

- **API Key Security**: Stored in secure storage, never in code
- **Network Security**: HTTPS-only communication
- **Data Validation**: Input sanitization and validation
- **Error Handling**: No sensitive data in error messages


## 🙏 Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for providing the API
- Flutter team for the amazing framework
- Open source community for the excellent packages




[⬆ Back to top](#-movies-app)

</div>
