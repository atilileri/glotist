# Glotist Architecture

This document describes the architectural patterns and principles used in the Glotist application.

## Clean Architecture

The project follows the principles of Clean Architecture, separating the application into distinct layers:

### 1. Domain Layer (The Heart)
The most inner layer. Contains the business logic and rules. It has no dependencies on any other layer.
- **Entities**: Simple POJOs (Plain Old Java Objects) representing the core business data.
- **Use Cases**: Encapsulate the business logic of the application.
- **Repositories (Interfaces)**: Define how the data should be accessed.

### 2. Data Layer
The outermost layer for external concerns. Responsible for retrieving and saving data.
- **Repositories (Implementations)**: Implementations of the domain repository interfaces.
- **Data Sources**: External APIs, databases (Supabase), or local storage.
- **Models (DTOs)**: Data Transfer Objects used to parse JSON from APIs.

### 3. Presentation Layer
Responsible for how the data is presented to the user.
- **Bloc/Cubit**: State management logic.
- **Pages**: Full screens of the application.
- **Widgets**: Reusable UI components.

## Directory Structure

```
lib/
├── core/               # Shared utilities, DI, and app-wide configuration
├── features/           # Feature-based organization
│   ├── chat/           # Chat feature (data, domain, presentation)
│   └── onboarding/     # Onboarding feature
└── main.dart           # Application entry point
```

## State Management

We use `flutter_bloc` for state management to ensure a clear separation between UI and logic.

## Dependency Injection

We use `get_it` and `injectable` (if added) for managing dependencies across the application. Centralized initialization is located in `lib/core/di/injection_container.dart`.
