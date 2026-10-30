# Bookly App

A Flutter application for discovering free programming books through the Google Books API. The app presents book collections, displays book information and preview links, and includes a search screen UI.

> **Project status:** The home and book-details flows are connected to the Google Books API. The current search screen is a UI placeholder and is not yet connected to a search request.

## Overview

Bookly App is built with Flutter and Dart. Its interface uses a dark theme and separates shared infrastructure from feature-specific code.

The application currently includes:

- An animated splash screen that navigates to the home screen.
- A home screen with horizontally displayed featured books and a vertically displayed latest-books section.
- Book details, including the cover, title, publication date, page count, preview action, and a “You may also like” section.
- A search screen layout with a text field and a sample results list.
- Remote book-cover loading with cached image support.
- Loading and error states for the Cubit-driven book lists.

Book data is retrieved from the [Google Books API](https://developers.google.com/books/docs/v1/using).

## Screens and current behavior

| Screen / area | Current implementation |
|---|---|
| Splash | Displays the local app logo and an animated “Read Free Books” message, then navigates to Home after two seconds. |
| Home | Loads two book collections through separate Cubits and displays loading, error, and success states. |
| Featured books | Displays a horizontal list of book covers. Selecting a cover opens its details. |
| Latest books | Displays a vertical list of books with cover, title, publication date, a “Free” label, and page-count value. |
| Book details | Displays the selected book's cover, title, publication date, page count, preview action, and a similar-books list. |
| Search | Displays a search field and sample book rows. Search input is not currently connected to the API, and the displayed rows are hard-coded. |

### Important implementation notes

- The repository method named `fetchBestSellerBooks()` currently requests programming-subject volumes; it does not use a dedicated bestseller feed.
- `fetchSimilarBooks(category:)` currently does not use its `category` argument when building the request. It requests programming-subject volumes instead.
- The search screen currently has no search Cubit, repository method, or API-backed result flow.
- The “Free” labels and preview button are UI behavior; availability and access are determined by the data returned by Google Books.
- The similar-books section is populated through the existing similar-books Cubit, but its request is not yet category-specific.

These notes describe the current source code and are not claims about planned functionality.

## Tech stack

### Core

- **Flutter** — UI toolkit.
- **Dart** — application language.
- **Material Design** — widgets and theming.

### Packages

| Package | Usage in this project |
|---|---|
| `flutter_bloc` | Cubit-based state management and `BlocBuilder` UI updates. |
| `dio` | HTTP requests to Google Books API. |
| `dartz` | `Either` result type for repository success/failure handling. |
| `equatable` | Value equality for book models and Cubit states. |
| `get_it` | Dependency registration and service lookup. |
| `go_router` | Application route configuration and navigation. |
| `cached_network_image` | Loading and caching remote book-cover images. |
| `google_fonts` | Montserrat text theme. |
| `font_awesome_flutter` | Icons used in the interface. |
| `url_launcher` | Opening book preview links externally. |
| `cupertino_icons` | Cupertino icon package included in dependencies. |

The project also declares the local **GT Sectra Fine** font and Material icons.

## Architecture

The source code follows a feature-oriented structure, with shared infrastructure in `core` and application features under `features`.

```text
lib/
├── main.dart
├── constants.dart
├── core/
│   ├── errors/
│   │   └── failure.dart
│   ├── function/
│   │   └── launch_url.dart
│   ├── utils/
│   │   ├── api_server.dart
│   │   ├── app_router.dart
│   │   ├── server_locator.dart
│   │   └── styles.dart
│   └── widget/
│       ├── custom_button.dart
│       ├── custom_error_widget.dart
│       └── custom_loading_indicator.dart
└── features/
    ├── home/
    │   ├── data/
    │   │   ├── models/
    │   │   │   └── book_model/
    │   │   └── repo/
    │   └── presentation/
    │       ├── manager/
    │       │   ├── featured_books_cubit/
    │       │   ├── news_books/
    │       │   └── similar_book_cubit/
    │       └── views/
    │           └── widget/
    ├── search/
    │   └── presentation/
    │       └── view/
    │           └── widgets/
    └── splash/
        └── presentation/
            └── views/
                └── widget/
assets/
├── fonts/
│   └── GT Sectra Fine Regular.ttf
└── images/
    ├── Logo.png
    └── test_image.png
```

### Data flow

1. `main()` calls `setupServicesLocator()` before starting the application.
2. The service locator registers `HomeRepoImpl`, which receives an `ApiServer` backed by Dio.
3. `ApiServer` sends GET requests to the Google Books API base URL: `https://www.googleapis.com/books/v1/`.
4. `HomeRepoImpl` converts API items into `BookModel` objects and returns an `Either<Failure, List<BookModel>>`.
5. `FeaturedBooksCubit`, `NewsBooksCubit`, and `SimilarBookCubit` expose loading, success, and failure states to the presentation layer.
6. `GoRouter` handles splash, home, search, and book-details routes. The selected `BookModel` is passed to the details route through route `extra`.

## Requirements

Install the following before running the application:

- Flutter SDK compatible with the Dart constraint declared in `pubspec.yaml` (`^3.6.0`).
- Dart SDK provided by your Flutter installation.
- Git.
- A supported development environment and platform toolchain.

The repository currently includes a **Linux desktop runner**. Other platform runner directories are not present in the checked-in project tree.

## Getting started

### 1. Clone the repository

```bash
git clone https://github.com/Eng-YousefAlazhari/bookly_app.git
cd bookly_app
```

### 2. Check your Flutter installation

```bash
flutter doctor
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

For a connected device or an available Flutter target:

```bash
flutter run
```

To run using the Linux desktop runner, use a Linux environment with Flutter desktop support enabled:

```bash
flutter run -d linux
```

## API

The application uses the Google Books API v1. The API base URL is configured in:

`lib/core/utils/api_server.dart`

The current repository requests are implemented in:

`lib/features/home/data/repo/home_repo_impl.dart`

No API key or environment variable is configured in the current source code. Network access is required for API-backed book lists and remote cover images.

For API documentation, see the [Google Books API documentation](https://developers.google.com/books/docs/v1/using).

## Project configuration

- Package name: `bookly_app`
- Version: `1.0.0+1`
- Dart SDK constraint: `^3.6.0`
- Main entry point: `lib/main.dart`
- App theme: dark Material theme with a custom dark background color.
- Font theme: Montserrat through Google Fonts; GT Sectra Fine is declared as a local font asset.

## Testing and analysis

The project includes `flutter_test` and `flutter_lints` as development dependencies. No test files are currently present in the repository tree.

Run static analysis with:

```bash
flutter analyze
```

Run the test suite after adding or checking in tests:

```bash
flutter test
```

## Current limitations and possible next steps

The following are opportunities to complete or strengthen the current implementation:

- Connect the search field to a search Cubit and a repository/API query.
- Replace the hard-coded search results with real Google Books results.
- Apply the requested category in `fetchSimilarBooks(category:)`.
- Review and validate the Google Books query parameters used by the repository methods.
- Handle empty or missing API fields safely before force-unwrapping book metadata in widgets.
- Add tests for JSON models, repository behavior, Cubits, and key UI flows.
- Add screenshots or a demo recording to document the interface.

## Contributing

Contributions are welcome. A practical workflow is:

1. Fork the repository.
2. Create a feature branch.
3. Make focused changes and add tests where appropriate.
4. Run `flutter analyze` and `flutter test`.
5. Open a pull request describing the change.

## License

No license file is currently present in the repository. Unless a license is added, the project should not be assumed to be available for reuse, redistribution, or modification under an open-source license.

---

<p align="center">
  Built with Flutter and the Google Books API.
</p>
