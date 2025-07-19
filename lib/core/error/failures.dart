import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class GenericFailure extends Failure {
  const GenericFailure({required super.message});

  @override
  List<Object?> get props => [message];
}

GenericFailure appFailure(AppException appException) =>
    GenericFailure(message: appException.message);
