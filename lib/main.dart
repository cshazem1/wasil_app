import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:wasil_task/core/utils/constants.dart';
import 'package:wasil_task/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/bloc_observer.dart';
import 'core/injectable/get_it.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'features/cart/data/models/cart_item_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemModelAdapter());
  await Hive.openBox<CartItemModel>(Constants.cartBox);
  Bloc.observer = MyBlocObserver();
  runApp(const WasilTaskApp());
}

class WasilTaskApp extends StatelessWidget {
  const WasilTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CartCubit>()..loadCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoutes.products,
      ),
    );
  }
}
