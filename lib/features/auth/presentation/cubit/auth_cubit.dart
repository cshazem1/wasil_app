import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/use_case/login_usecase.dart';
import '../../domain/use_case/register_usecase.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthCubit(this.loginUseCase, this.registerUseCase) : super(AuthInitial());
  Future<void> login(AuthParams params) async {
    emit(LoginLoading());
    final result = await loginUseCase(params);
    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  Future<void> register(AuthParams params) async {
    emit(RegisterLoading());
    final result = await registerUseCase(params);
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (user) => emit(RegisterSuccess(user)),
    );
  }
}
