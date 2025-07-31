# GetX Clean Architecture Boilerplate

This project is a boilerplate for building Flutter applications using the GetX package and clean architecture principles. It provides a structured and scalable foundation for your Flutter projects.

## Features

- **GetX State Management**: Efficient and reactive state management.
- **Clean Architecture**: Separation of concerns with proper layering.
- **API Integration**: Built-in support for API calls using Dio.
- **Routing**: Named routes with GetX navigation.
- **Theming**: Light and dark mode support.
- **Localization**: Multi-language support using GetX translations.
- **Error Handling**: Centralized error handling.

## Project Structure

The project follows the clean architecture pattern and is organized as follows:

```
lib/
├── main.dart                # Entry point of the application
├── src/
│   ├── controllers/         # GetX controllers for state management
│   ├── core/                # Core utilities, constants, and services
│   ├── data/                # Data layer (repositories, data sources, models)
│   ├── domain/              # Domain layer (entities, use cases, repositories)
│   ├── presentation/        # UI layer (views, widgets, routes, translations)
│   └── shared/              # Shared components and utilities
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/getx_clean_architecture_boilerplate.git
   ```

2. Navigate to the project directory:
   ```bash
   cd getx_clean_architecture_boilerplate
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Generate App Launcher Icons:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

5. Run the application:
   ```bash
   flutter run
   ```

## Usage

### Adding a New Feature

1. **Domain Layer**:
   - Define entities and use cases.
   - Create an abstract repository interface.

2. **Data Layer**:
   - Implement the repository interface.
   - Add data sources (e.g., API calls, local storage).

3. **Presentation Layer**:
   - Create views and widgets.
   - Add a GetX controller for state management.

4. **Routing**:
   - Define routes in `app_routes.dart`.

### Theming

- Switch between light and dark themes using the `ThemeController`.

### Localization

- Add translations in the `translations` folder.
- Use `.tr` for string translations in the UI.

## App Icon Setup

This project uses the `flutter_launcher_icons` package to generate app launcher icons.

### Steps to Generate App Launcher Icons

1. Add the `flutter_launcher_icons` package to your `pubspec.yaml`:
   ```yaml
   dev_dependencies:
     flutter_launcher_icons: ^0.10.0

   flutter_icons:
     android: true
     ios: true
     image_path: "assets/icons/app_icon.png"
   ```

2. Run the following command to generate the launcher icons:
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

This will generate the necessary launcher icons for both Android and iOS platforms.

### Reference

For more details, visit the [flutter_launcher_icons documentation](https://pub.dev/packages/flutter_launcher_icons).

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For questions or support, please contact [faysal.ewucse@gmail.com].
