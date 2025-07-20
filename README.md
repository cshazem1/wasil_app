# Wasil Task App Clean Architecture Project

## Overview

This project is a Flutter application following **Clean Architecture** principles with Firebase Authentication integration.  
It is organized using feature-based folders and follows best practices with separation of concerns, dependency injection, and error handling using Either.

---

| ![IMG-1](https://github.com/user-attachments/assets/d9bbb067-faa4-4064-9a05-d1c783288ee3) | ![IMG-2](https://github.com/user-attachments/assets/ec05b560-1d50-4a65-b9a9-2c7c66a762c8) |
|---|---|
| ![IMG-3](https://github.com/user-attachments/assets/60cde28e-5990-49c1-ae5a-f73ec627e728) | ![IMG-4](https://github.com/user-attachments/assets/a4db2f4c-92eb-4877-b800-9a637fcd9047) |
| ![IMG-5](https://github.com/user-attachments/assets/3dd3b2a7-c3c1-4761-9b87-32e9d6b0b6f3) | ![IMG-6](https://github.com/user-attachments/assets/b585fe35-a160-42f4-b072-3a56fdd5a994) |
| ![IMG-7](https://github.com/user-attachments/assets/e91e9b87-bb5a-423f-a8b9-466636c272af) |  |


## Project Structure

The project is divided into several **features**, each containing its own domain, data, and presentation layers.

### Features

auth/
Handles user authentication (login & registration) using Firebase Auth.

If the user is already logged in, they are redirected directly to the products page.

If not logged in, they see the login screen.

cart/
Manages shopping cart functionality, such as adding/removing items and adjusting quantities.

The cart is stored locally on the device and is unique per user.

products/
Displays the list of products.

Includes product details screens for each product.

splash/
Splash screen that checks the user’s authentication status on app start.

Redirects authenticated users to the products page.

Sends unauthenticated users to the login page.

###Cart & Guest User Handling
The cart data is stored locally on the device and is separated per user.

When a user is browsing as a guest (not logged in) and adds items to the cart, these items are stored locally under the guest session.

If the guest user decides to log in before checking out, the guest cart data will be merged into the logged-in user’s cart automatically.

This way, nothing the guest added will be lost after logging in, ensuring a seamless shopping experience.



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


