# CharacterFinder

A mobile application built with Flutter that fetches and displays character data from the
Rick and Morty API. This app features a clean, responsive UI that allows users to browse,
search, and filter through character information, with detailed views for individual characters.
Designed as a demonstration of effective API integration, state management, and UI design
principles in Flutter.

## Features
- Character listing with pagination
- Search functionality by name
- Detailed character information view
- Error handling and loading states
- Responsive design for various screen sizes

## Tech Stack
- Flutter for cross-platform mobile development
- HTTP package for API integration
- Stacked Architecture for state management
- Flutter spinkit package for animated loading indicator
- No backend required, uses public Rick and Morty API

## Stacked Architecture

This project uses the [Stacked Architecture](https://stacked.filledstacks.com/), 
a Flutter MVVM (Model-View-ViewModel) framework that helps in separating business logic from UI. 
It encourages testable, scalable, and maintainable code by promoting a clear separation of concerns.

With Stacked:
- UI logic resides in **ViewModels**
- Navigation and services are managed with dependency injection
- Reactive state updates with `notifyListeners()` simplify state management

Learn more about Stacked here: [https://stacked.filledstacks.com/](https://stacked.filledstacks.com/)

## Getting Started

### Prerequisites
- Flutter (latest stable version)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation
1. Clone this repository
```bash
git clone https://github.com/masteribro/CharacterFinder.git
```

2. Navigate to project directory
```bash
cd character-finder
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Acknowledgements
- [Rick and Morty API](https://rickandmortyapi.com/) for providing the data# CharacterFinder
