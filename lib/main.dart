import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc_observer.dart';
import 'core/injectable/get_it.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const WasilTaskApp());
}
class WasilTaskApp extends StatelessWidget {
  const WasilTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.products,
    );
}}
