import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/usecase.dart';
import 'package:wasil_task/features/auth/domain/use_case/login_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@LazySingleton()
class RegisterUseCase
    extends UseCase<Future<Either<Failure, UserEntity>>, AuthParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(AuthParams params) {
    return repository.register(params.email, params.password);
  }
}
