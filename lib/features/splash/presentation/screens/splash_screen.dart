import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasil_task/core/utils/extensions.dart';

import '../../../../core/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        context.pushReplacementNamed(AppRoutes.products);
      } else {
        context.pushReplacementNamed(AppRoutes.login);
      }
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
