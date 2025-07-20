import 'package:flutter/material.dart';

extension NamedNavigation on BuildContext {
  // Push by route name
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  // Replace current with new route by name
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  // Push and remove all previous routes
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  // Pop the current route
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
