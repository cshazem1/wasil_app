# Wasil Task App Clean Architecture Project

## Overview

This project is a Flutter application following **Clean Architecture** principles with Firebase Authentication integration.  
It is organized using feature-based folders and follows best practices with separation of concerns, dependency injection, and error handling using Either.

---

![IMG-20250720-WA0052](https://github.com/user-attachments/assets/d9bbb067-faa4-4064-9a05-d1c783288ee3)
![IMG-20250720-WA0051](https://github.com/user-attachments/assets/ec05b560-1d50-4a65-b9a9-2c7c66a762c8)
![IMG-20250720-WA0057](https://github.com/user-attachments/assets/60cde28e-5990-49c1-ae5a-f73ec627e728)
![IMG-20250720-WA0056](https://github.com/user-attachments/assets/a4db2f4c-92eb-4877-b800-9a637fcd9047)
![IMG-20250720-WA0055](https://github.com/user-attachments/assets/3dd3b2a7-c3c1-4761-9b87-32e9d6b0b6f3)
![IMG-20250720-WA0054](https://github.com/user-attachments/assets/b585fe35-a160-42f4-b072-3a56fdd5a994)
![IMG-20250720-WA0053](https://github.com/user-attachments/assets/e91e9b87-bb5a-423f-a8b9-466636c272af)

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


