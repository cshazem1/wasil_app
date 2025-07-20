# Wasil Task App Clean Architecture Project

## Overview

This project is a Flutter application following **Clean Architecture** principles with Firebase Authentication integration.  
It is organized using feature-based folders and follows best practices with separation of concerns, dependency injection, and error handling using Either.

---

## Project Structure

The project is divided into several **features**, each containing its own domain, data, and presentation layers.

### Features

- **auth/**  
  Handles user authentication (login and registration) using Firebase Auth.

- **cart/**  
  Manages shopping cart functionalities like adding/removing items and quantity adjustment.

---

### Clean Architecture Layers per Feature

Each feature folder contains:

- **domain/**  
  - `entities/` : Defines core business entities (e.g., `UserEntity`, `CartItem`).  
  - `repositories/` : Abstract repository interfaces.  
  - `usecases/` : Business logic use cases (e.g., `LoginUseCase`, `RegisterUseCase`).

- **data/**  
  - `models/` : Data models (e.g., `UserModel` extending `UserEntity`).  
  - `datasources/` : Remote and local data sources implementations (e.g., `AuthRemoteDataSourceImpl` for Firebase).  
  - `repositories/` : Concrete repository implementations that use data sources.

- **presentation/**  
  - `screens/` : UI screens (e.g., `LoginScreen`, `RegisterScreen`).  
  - `cubit/` or `bloc/` : State management classes.  
  - `widgets/` : Reusable widgets specific to the feature.

---

## Dependency Injection

- Uses `injectable` package for automatic dependency injection.
- Firebase services are provided via a dedicated injectable module.
- Example:
  ```dart
  @module
  abstract class FirebaseInjectableModule {
    @lazySingleton
    FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
  }
