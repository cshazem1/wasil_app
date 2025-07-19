import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wasil_task/core/injectable/get_it.config.dart';

final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
   getIt.init();
}
