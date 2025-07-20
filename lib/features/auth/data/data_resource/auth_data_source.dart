// lib/core/di/firebase_injectable_module.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthDataSource {
  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
}
