import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';
@LazySingleton()
class LoginUseCase extends UseCase<Future<Either<Failure,UserEntity>>,AuthParams>{
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(AuthParams authParams) {
    return repository.login(authParams.email, authParams.password);
  }
}
class AuthParams{
  final String password;
  final String email;
  AuthParams({required this.email,required this.password});
}