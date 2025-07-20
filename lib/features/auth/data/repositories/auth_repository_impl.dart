import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      // if (user == null) {
      //   return left(appFailure(appException(exception: e)));
      // }

      return right(UserModel.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      return left(appFailure(appException(exception: e)));
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        // return left(ServerFailure('User is null'));
      }

      return right(UserModel.fromFirebaseUser(user));
    } on FirebaseAuthException catch (e) {
      return left(appFailure(appException(exception: e)));
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _firebaseAuth.signOut();
      return right(unit);
    } catch (e) {
      return left(appFailure(appException(exception: e)));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return right(UserModel.fromFirebaseUser(user));
    }
    return right(null);
  }
}
